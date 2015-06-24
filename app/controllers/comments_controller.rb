class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)
    if @comment.save
      respond_to do |wants|
        wants.html {redirect_to project_path(@project)}
        wants.js { render partial: "create_comment" }
      end
    else
      
    end
  end
  
  def complete_action
    puts "********************************************************************************"
    puts "params are #{params.inspect}"
    @comment = Comment.find(params[:comment_id])
    @project = Project.find(params[:project_id])
    if @project.comments.include? @comment
      begin
        @comment.actionable  = false
        @comment.resolved    = true
        @comment.resolver    = current_user
        @comment.resolved_at = Time.now
        @comment.save
      end
    end
    
    respond_to do |wants|
      wants.js { }
    end
  end
  
  private
  def comment_params
    params.require(:comment).permit(:body, :actionable, :author_id, :project_id)
  end
end
