# frozen_string_literal: true

class StudentsController < ApplicationController
  def index
    authorize(Student)
    # authorize(User)
    students = Student.all
    render jsonapi: students, include: ['user', 'stusons']
  end

  def create
    authorize(Student)
    student = Student.new(student_params)
    student.user.role = 'student'
    # binding.pry
    if student.save
      render jsonapi: student, include: ['user', 'stusons']
    else
      render json: student.errors, status: :unprocessable_entity
    end
  end

  def show
    authorize(Student)
    render jsonapi: Student.find(params[:id]), include: ['user', 'stusons']
  end

  def edit; end

  def update
    authorize(Student)
    student = Student.find(params[:id])
    if student.update(student_params)
      render jsonapi: student,
             include: ['user', 'stusons']
                # %w(
                #   student.user
                #   student.stusons
                # )
    else
      render json: student.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize(Student)
    student = Student.find(params[:id])
    if student.destroy
      render json: { student_destroyed: 'student was destroyed' }
    else
      render json: student.errors
    end
  end

  private

  def student_params
    params.require(:student).permit(
      :birthPlace, :rank,
      user_attributes: %i[
        id
        profile
        frst_name
        last_name
        email
        password
        password_confirmation
        code
      ],
      stusons_attributes: %i[
        lesson
        mark
      ]
    )
  end
end
