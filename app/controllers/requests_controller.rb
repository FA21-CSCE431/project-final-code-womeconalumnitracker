# frozen_string_literal: true

# Requests is what controls the authorization of points for participants

# Class defines methods for accepting and rejecting participant point requests
class RequestsController < ApplicationController
  before_action :set_request, only: %i[show edit update destroy accept deny]

  # GET /requests or /requests.json
  def index
    return nil if authenticate_officer == false

    @students = Student.all
    @requests = Request.all
  end

  def accept
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request }
      end
      return nil
    end
    @request.student.increment!(:total_points, @request.points_requested)

    if @request.request_type == "Volunteer"
      @request.student.increment!(:volunteer_points, @request.points_requested)
    end

    if @request.request_type == "Social"
      @request.student.increment!(:social_points, @request.points_requested)
    end

    if (@request.student.volunteer_points >= 3) && (@request.student.total_points >= 15) && (@request.student.social_points >= 1) && (@request.student.paid_dues) && !(@request.student.active_member)
      @request.student.toggle!(:active_member)
    end

    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully accepted.' }
      format.json { head :no_content }
    end
  end

  def deny
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request }
      end
      return nil
    end
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully denied.' }
      format.json { head :no_content }
    end
  end

  # GET /requests/1 or /requests/1.json
  def show; end

  # GET /requests/new
  def new
    @other_events = OtherEvent.all
    @request = Request.new
  end

  # GET /requests/1/edit
  def edit
    @other_events = OtherEvent.all
  end

  # POST /requests or /requests.json
  def create
    @request = Request.new(request_params)
    @other_events = OtherEvent.all

    respond_to do |format|
      if @request.save
        format.html { redirect_to @request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @request }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1 or /requests/1.json
  def update
    @other_events = OtherEvent.all
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request }
      end
      return nil
    end
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to @request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1 or /requests/1.json
  def destroy
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request }
      end
      return nil
    end
    # @request.student.increment!(:total_points, @request.points_requested) # for testing
    @request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @request = Request.find(params[:id])
  end

  def authenticate_officer
    @officers = Officer.all
    @officers.each do |officer|
      return true if officer.email == session[:email]
    end
    false
  end

    # Only allow a list of trusted parameters through.
    def request_params
      params.require(:request).permit(:event_id, :UIN, :date_of_request, :points_requested, :request_time, :approved, :id, :request_type)
    end
end
