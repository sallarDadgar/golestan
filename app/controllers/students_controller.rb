class StudentsController < ApplicationController
  def index
    authorize(Student)
    # authorize(User)
    students = Student.all
    render jsonapi: students
  end

  def create
    authorize(Student)
    # authorize(User)
    # for(int i; i == params['student']['stusons'].length; i++){
    #   Stuson.new(params['student']['stusons'])
    # }
    student = Student.new(student_params)
    student.user.role = 'student'
    # student.stusons.builld
    # student.stusons_ids =

    if student.save
        render json: {studentSaved: true, aaa: Stuson.count}
    else
        render json: {studentSaved: false}
    end
  end


  def show
    authorize(Student)
    render jsonapi: Student.find(params[:id])
  end

  def edit
  end

  def update
    authorize(Student)
    student = Student.find(params[:id])
    student.update_attributes!(student_params)
    if student.update(student_params)
      render json: { newname: student.user.frst_name}
    else
      render json: { newname: 'not updated'}
    end
  end

  def destroy
    authorize(Student)
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
          # stusons_attributes: [
          #   :lesson,
          #   :mark
          # ]
      )
  end
end
