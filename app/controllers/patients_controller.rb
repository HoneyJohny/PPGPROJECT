class PatientsController < ApplicationController

before_action :authenticate_user!
helper_method :sort_column, :sort_direction
def index
    if current_user.email =='doctor@gmail.com'
    @patients = Patient.order(sort_column + " " + sort_direction)
    else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
  end

def show
    if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
      @patient = Patient.find(params[:id])
    else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
end

def new
    if current_user.email =='hospital@gmail.com'
    @patients = Patient.new  
    else
    
    redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
end

def edit
  if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
    @patient = Patient.find(params[:id])
  else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
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
  if current_user.email =='doctor@gmail.com' or current_user.email =='hospital@gmail.com'
  @patient = Patient.find(params[:id])
  @patient.destroy
  else
      redirect_to welcome_index_path,alert:"UNAUTHORISED ACCESS"
    end
 
  redirect_to patients_path
end
 private
  def patient_params
    params.require(:patient).permit(:name, :age, :height, :weight, :bloodgroup, :gender)
  end

  def sort_column
    Patient.column_names.include?(params[:sort]) ? params[:sort] : "regid"
  end
  
  def sort_direction
   %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end