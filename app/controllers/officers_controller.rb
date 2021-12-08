# frozen_string_literal: true

# Officers are different from normal users, thus this controller enables admins to add officers

# This class defines officer actions and checks that only authorized users can perform these actions
class OfficersController < ApplicationController
  before_action :set_officer, only: %i[show edit update destroy]

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_officer
    @officer = Officer.find(params[:id])
  end

  def authenticate_officer
    @officers = Officer.all
    @officers.each do |officer|
      return true if officer.email == session[:email]
    end
    false
  end

  # Only allow a list of trusted parameters through.
  def officer_params
    params.require(:officer).permit(:email)
  end

  # GET /officers or /officers.json
  def index
    @officers = Officer.all
  end

  def testmode
    # MAKE SURE TO DUMP THE DB LATER, THIS SHOULD NOT BE ALLOWED IN REAL VERSION OF THE APP
    #################################################################
    Officer.create(email: session[:email])
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'You can now perform Officer functions.' }
      format.json { render :show, status: :success }
    end
    #################################################################
  end

  # GET /officers/1 or /officers/1.json
  def show; end

  # GET /officers/new
  def new
    @officer = Officer.new
  end

  # GET /officers/1/edit
  def edit; end

  # POST /officers or /officers.json
  def create
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to officers_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    @officer = Officer.new(officer_params)

    respond_to do |format|
      if @officer.save
        format.html { redirect_to @officer, notice: 'Officer was successfully created.' }
        format.json { render :show, status: :created, location: @officer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @officer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /officers/1 or /officers/1.json
  def update
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to officers_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    respond_to do |format|
      if @officer.update(officer_params)
        format.html { redirect_to @officer, notice: 'Officer was successfully updated.' }
        format.json { render :show, status: :ok, location: @officer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @officer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /officers/1 or /officers/1.json
  def destroy
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to officers_path, alert: 'You are not authorized to perform this action!' }
        format.json { render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    @officer.destroy
    respond_to do |format|
      format.html { redirect_to officers_url, notice: 'Officer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
