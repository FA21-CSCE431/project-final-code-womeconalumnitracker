# frozen_string_literal: true

# Meeting participation controller is used to track participant meeting points

# Class controller defines necessary CRUD actions and relevant parameters for referencing meetings
class MeetingParticipationsController < ApplicationController
  skip_before_action :authenticate_admin!
  before_action :set_meeting_participation, only: %i[destroy]

  # GET /meeting_participations or /meeting_participations.json
  def index
    @students = Student.all
    @meeting_participations = if params[:id].present?
                                MeetingParticipation.where(meeting_name: params[:id])
                              else
                                MeetingParticipation.all
                              end
  end

  # GET /meeting_participations/1 or /meeting_participations/1.json
  def show; end

  # GET /meeting_participations/new
  def new
    @meetings = Meeting.all
    @meeting_participation = MeetingParticipation.new
  end

  # GET /meeting_participations/1/edit
  def edit; end

  # POST /meeting_participations or /meeting_participations.json
  def create
    @meeting_participation = MeetingParticipation.new(meeting_participation_params)
    @meetings = Meeting.all
    # do some checks here to see if they are in the database
    # we will probably call the student controller and do some kind of isPresent() function
    if is_present(@meeting_participation.UIN)
      @meeting_participation.student.increment!(:meeting_points, 3)
    else
      respond_to do |format|
        #format.html { redirect_to new_student_path, notice: 'You are currently not in the system! Please enter your information here first.'}
        format.html { redirect_to new_student_path(@meeting_participation, participating: 'true', UIN: @meeting_participation.UIN, meeting_name: @meeting_participation.meeting_name) }
        format.json { render :show, status: :unprocessable_entity}
      end
      return
    end

    respond_to do |format|
      if @meeting_participation.save
        format.html { redirect_to @meeting_participation, notice: 'Meeting participation was successfully created.' }
        format.json { render :show, status: :created, location: @meeting_participation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meeting_participations/1 or /meeting_participations/1.json
  def update
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to students_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @meeting_participation }
      end
      return nil
    end

    respond_to do |format|
      if @meeting_participation.update(meeting_participation_params)
        format.html { redirect_to @meeting_participation, notice: 'Meeting participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting_participation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting_participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meeting_participations/1 or /meeting_participations/1.json
  def destroy
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to students_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @meeting_participation }
      end
      return nil
    end

    @meeting_participation.destroy
    respond_to do |format|
      format.html do
        redirect_to meeting_participations_url, notice: 'Meeting participation was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_meeting_participation
    @meeting_participation = MeetingParticipation.find(params[:id])
  end

  # function to check if a student is present in the student database.
  def is_present(uin)
    @students = Student.all
    @students.each do |student|
      if student.UIN == uin
        return true
      end
    end
    return false
  end

  def authenticate_officer
    @officers = Officer.all
    @officers.each do |officer|
      return true if officer.email == session[:email]
    end
    false
  end

  # Only allow a list of trusted parameters through.
  def meeting_participation_params
    params.require(:meeting_participation).permit(:meeting_name, :UIN)
  end
end
