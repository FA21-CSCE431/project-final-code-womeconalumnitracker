class OfficersController < ApplicationController
  before_action :set_officer, only: %i[ show edit update destroy ]

  # GET /officers or /officers.json
  def index
    @officers = Officer.all
  end

  # GET /officers/1 or /officers/1.json
  def show
  end

  # GET /officers/new
  def new
    @officer = Officer.new
  end

  # GET /officers/1/edit
  def edit
  end

  # POST /officers or /officers.json
  def create
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to officers_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    @officer = Officer.new(officer_params)

    respond_to do |format|
      if @officer.save
        format.html { redirect_to @officer, notice: "Officer was successfully created." }
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
        format.html { redirect_to officers_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    respond_to do |format|
      if @officer.update(officer_params)
        format.html { redirect_to @officer, notice: "Officer was successfully updated." }
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
        format.html { redirect_to officers_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @officer }
      end
      return nil
    end

    @officer.destroy
    respond_to do |format|
      format.html { redirect_to officers_url, notice: "Officer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_officer
      @officer = Officer.find(params[:id])
    end

    def authenticate_officer
      if session[:email] == 'flyer36@tamu.edu'
        return true
      end
      @officers = Officer.all
      @officers.each do |officer|
        if officer.email == session[:email]
          return true
        end
      end
      return false

    end

    # Only allow a list of trusted parameters through.
    def officer_params
      params.require(:officer).permit(:email)
    end
end