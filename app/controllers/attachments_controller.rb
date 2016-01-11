class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment

  def index
    attachments = @comment.attachments.all
    render json: attachments, status: :ok
  end

  def create
    attachment = Attachment.new(
      file: params[:file],
      name: params[:file].original_filename
    )
    if attachment.save
      render json: attachment, status: :created
    else
      render json: attachment.errors, status: :unprocessable_entity
    end
  end

  def destroy 
    attachment = @comment.attachments.find(params[:id])
    
    if attachment.destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def set_comment
    project = current_user.projects.find(params[:project_id])
    task = project.tasks.find(params[:task_id])
    @comment = task.comments.find(params[:comment_id])
  end

  def comment_params
    params.permit(:file).merge(comment: @comment)
  end
end