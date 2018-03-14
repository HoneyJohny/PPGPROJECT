class PatientsController < ApplicationController

def index
    if user_signed_in?
    if current_user.email =='doctor@gmail.com'
    @patients = Patient.all
    else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
    else
    redirect_to new_user_session_path
    end
  end

def show
    if user_signed_in?
    if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
      @patient = Patient.find(params[:id])
    else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
    else
      redirect_to new_user_session_path
    end
end

def new
    if user_signed_in?
    if current_user.email =='hospital@gmail.com'
    @patients = Patient.new  
    else
    
    redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
    else
    redirect_to new_user_session_path
    end
end

def edit
  if user_signed_in?
  if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
    @patient = Patient.find(params[:id])
  else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
  else
    redirect_to new_user_session_path
    end
end
  
def create
  @patient = Patient.new(patient_params)
  @patient.regid=Time.now.to_i
  if @patient.save
    redirect_to patient_path(@patient) 
  else
    render 'new'
  end
end

def update
  @patient = Patient.find(params[:id])
 
  if @patient.update(patient_params)
    redirect_to @patient
  else
    render 'edit'
  end
end

def destroy
  if user_signed_in?
  if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
  @patient = Patient.find(params[:id])
  @patient.destroy
  else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
  else
    redirect_to new_user_session_path
    end
 
  redirect_to patients_path
end
 private
  def patient_params
    params.require(:patient).permit(:name, :age, :height, :weight, :bloodgroup, :gender)
  end
end