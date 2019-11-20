class StudentsController < ApplicationController
  def index
    students = Student.all
    render jsonapi: students
  end

  def create
      # binding.pry
      student = Student.new(student_params)
      # binding.pry
      student.user.role = 'student'

      if student.save
          # binding.pry
          render json: {studentSaved: true}
      else
        #   binding.pry
          render json: {studentSaved: false}
      end
  end


  def show
    # student = Student.new()
    # student.user.role = 'student'
    render jsonapi: Student.find(params[:id])
  end

  def edit
  end

  def update
    student = Student.find(params[:id])
    student.update_attributes!(student_params)
    if student.update(student_params)
      render json: { newname: student.user.frst_name}
    else
      render json: { newname: 'not updated'}
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy
    render json: {studentcounted: Student.count, usercounted: User.count}
  end

  private

  def student_params
      params.require(:student).permit(
          :birthPlace,:rank,
          user_attributes: [
              :id,
              :profile,
              :frst_name,
              :last_name,
              :email,
              :password,
              :code,
          ]
      )
  end
end
