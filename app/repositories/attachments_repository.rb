class AttachmentsRepository < BaseRepository
  def initialize(current_user, params)
    super
    @comment = @current_user.projects.find(@params['project_id']).tasks
      .find(@params['task_id']).comments.find(@params['comment_id'])
  end


  def list
    @comment.attachments.all
  end

  def remove_item
    @comment.attachments.find(@params['id']).destroy
  end

  def create_item
    attachment = Attachment.new(
      file: @params['file'],
      name: @params['file'].original_filename,
      comment: @comment
    )
    status = attachment.save
    [status, attachment]
  end
end