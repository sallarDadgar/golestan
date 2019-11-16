class StudentsController < ApplicationController
  def index
  end

  def create
      student = Student.new(student_params)
      student.user.role = 'student'

      if student.save
          render json: {studentSaved: true}
      else
        #   binding.pry
          render json: {studentSaved: false}
      end
  end

  private

  def student_params
      params.require(:student).permit(
          :birthPlace,:rank,
          user_attributes: [
            #   :id,
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
