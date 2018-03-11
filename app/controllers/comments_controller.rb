class CommentsController < ApplicationController
def create
    @patient = Patient.find(params[:patient_id])
    @comment = @patient.comments.create(comment_params)
    redirect_to patient_path(@patient)
  end

 def destroy
    @patient = Patient.find(params[:patient_id])
    @comment = @patient.comments.find(params[:id])
    @comment.destroy
    redirect_to patient_path(@patient)
  end
 
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
