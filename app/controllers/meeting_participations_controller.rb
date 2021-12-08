# frozen_string_literal: true

# Meeting participation controller is used to track participant meeting points

# Class controller defines necessary CRUD actions and relevant parameters for referencing meetings
class MeetingParticipationsController < ApplicationController
  before_action :set_meeting_participation, only: %i[show edit update destroy]

  # GET /meeting_participations or /meeting_participations.json
  def index
    @meeting_participations = if params[:id].present?
                                MeetingParticipation.where(meeting_id: params[:id])
                              else
                                MeetingParticipation.all
                              end
  end

  # GET /meeting_participations/1 or /meeting_participations/1.json
  def show; end

  # GET /meeting_participations/new
  def new
    @meeting_participation = MeetingParticipation.new
  end

  # GET /meeting_participations/1/edit
  def edit; end

  # POST /meeting_participations or /meeting_participations.json
  def create
    @meeting_participation = MeetingParticipation.new(meeting_participation_params)

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

  # Only allow a list of trusted parameters through.
  def meeting_participation_params
    params.require(:meeting_participation).permit(:meeting_id, :UIN)
  end
end
