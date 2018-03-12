class PatientsController < ApplicationController

def index
    if user_signed_in?
    @patients = Patient.all
    else
    redirect_to new_user_session_path
    end
  end

def show
    if user_signed_in?
    @patient = Patient.find(params[:id])
    else
    redirect_to new_user_session_path
    end
  end
  def new
@patients = Patient.new  
end
def edit
  @patient = Patient.find(params[:id])
end
  def create
  @patient = Patient.new(patient_params)
  @patient.regid=Time.now.to_i
  if @patient.save
    redirect_to patients_url 
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
  @patient = Patient.find(params[:id])
  @patient.destroy
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