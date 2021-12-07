# frozen_string_literal: true

# Controller for describing the interaction of a student which should be different than admin use case

# Class identifies student users and defines methods for CRUD of student users, points and PII
class StudentsController < ApplicationController
  skip_before_action :authenticate_admin!
  before_action :set_student, only: %i[show edit update destroy]
  # GET /students or /students.json
  def index
    @students = Student.all
  end

  # GET /students/1 or /students/1.json
  def show; end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit; end

  # POST /students or /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.participating != true and authenticate_officer != true
        respond_to do |format|
          format.html { redirect_to students_path, notice: "You are not authorized to perform this action!"}
          format.json {render :show, status: :bad_request, location: @student }
        end
        return nil
      end
      if @student.save
        @student.total_points = @student.meeting_points + @student.volunteer_points + @student.social_points
        if @student.participating == true
          MeetingParticipation.create!(meeting_name: @student.meeting_name, UIN: @student.UIN)
          @student.increment!(:meeting_points, 3)
          format.html { redirect_to students_path, notice: 'Student was successfully created. Participation for meeting has been added.' }
        else
          format.html { redirect_to students_path, notice: 'Student was successfully created.' }
        end
        if (@student.volunteer_points >= 3) && (@student.total_points >= 15) && (@student.social_points >= 1) && (@student.paid_dues) && !(@student.active_member)
          @student.toggle!(:active_member)
        end
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to students_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @student }
      end
      return nil
    end

    if @student.meeting_points && @student.volunteer_points && @student.social_points
      @student.total_points = @student.meeting_points + @student.volunteer_points + @student.social_points
    end # the purpose of this block is to update the total points before the params get updated, but this will not always work

    respond_to do |format|
      if @student.update(student_params)
        @student.total_points = @student.meeting_points + @student.volunteer_points + @student.social_points
        puts "HELLO"
        puts @student.total_points
        puts "HI"
        if (@student.volunteer_points >= 3) && (@student.total_points >= 15) && (@student.social_points >= 1) && (@student.paid_dues) && !(@student.active_member)
          @student.toggle!(:active_member)
        elsif ((@student.volunteer_points < 3) || (@student.total_points < 15) || (@student.social_points < 1) || !(@student.paid_dues)) && (@student.active_member)
          @student.toggle!(:active_member)
        end
        format.html { redirect_to students_path, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    # since UIN is a foreign key in both meetingparticipations and requests, we must delete the entry from those tables first

    if authenticate_officer == false
      respond_to do |format|
        format.html { redirect_to students_path, notice: "You are not authorized to perform this action!"}
        format.json {render :show, status: :bad_request, location: @student }
      end
      return nil
    end

    @meeting_participations = MeetingParticipation.all
    @meeting_participations.each do |meeting_participation|
      if meeting_participation.UIN == @student.UIN
        meeting_participation.destroy
      end
    end

    @requests = Request.all
    @requests.each do |request|
      if request.UIN == @student.UIN
        request.destroy
      end
    end

    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_officer
    @officers = Officer.all
    @officers.each do |officer|
      if officer.email == session[:email]
        return true
      end
    end
    return false
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def student_params
    params.require(:student).permit(:UIN, :first_name, :last_name, :meeting_points, :volunteer_points,
                                    :social_points, :total_points, :participating, :meeting_name, :active_member, :paid_dues)
  end
end
