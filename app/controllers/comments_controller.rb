class CommentsController < ApplicationController
  before_action :require_user_logged_in

  def new
    @comment = Comment.new
  end
  
  def create
    @lyric = Lyric.find(params[:lyric_id])
    @user = @lyric.user
    @comments = @lyric.comments
    @comment = @lyric.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = 'コメントしました。/ Commented!!'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'コメント失敗しました。 / Fail Commented!'
      render template: 'lyrics/show'
    end
  end
  
  private

  def comment_params
    params.require(:comment).permit(:content,:lyric_id)
  end
end
