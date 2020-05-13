class RequestsController < ApplicationController
  
  def index
    @applys = Request.joins(:lyric).where(lyrics: {user_id: current_user.id})
    c_counts()
  end
  
  def show
    @apply = Request.find(params[:id])
    c_counts()
  end
  
  def new
    @apply = current_user.requests.new
    @lyric = Lyric.find(params[:lyric_id])
    c_counts()
  end
  
  def create
    @apply = current_user.requests.new(apply_params)
    @apply.lyric_id = params[:lyric_id]
    @apply.permission = false
    
    @lyric = Lyric.find(params[:lyric_id])
    @user = @lyric.user
    @comment = Comment.new
    @comments = @lyric.comments
    
    if @apply.save
      flash[:success] = '『' + @lyric.title + '』の作曲応募しました。/  Applied for composition to "' + @lyric.title + '" !!'
      redirect_to @lyric
    else
      flash.now[:danger] = 'エラー発生！応募に失敗しました。 / Fail Applied for composition!'
      #render :new
      render template: 'lyrics/show'
    end
  end
  
  def edit
    @apply = Request.find(params[:id])
    @lyric = @apply.lyric
    c_counts()
  end
  
  def update
    @apply = Request.find(params[:id])
    @user = @apply.user
    @lyric = @apply.lyric
    
    if @apply.permission == true
      @apply.permission  = false
    else
      @apply.permission  = true
    end

    if @apply.save
      if @apply.permission == true
        flash[:success] = @user.name + 'の作曲申請を許可しました。/  Allowed to compose ' + @user.name + '!'
        redirect_to apply_lyric_path(@lyric)
      else
        flash[:secondary] = @user.name + 'の作曲許可を取り下げました/  Unallowed to compose ' + @user.name + '!'
        redirect_to apply_lyric_path(@lyric)
      end
    else
      flash.now[:danger] = 'エラー発生！応募に失敗しました。 / Fail Applied for composition!'
      render template: 'lyrics/show'
    end
  end

  def destroy
    @apply = current_user.requests.find_by(params[:id])
    @user = @apply.user
    @lyric = @apply.lyric
    
    if @apply
      @apply.destroy
      flash[:secondary] = '『' + @lyric.title + '』への使用依頼を削除しました。/ Delete request for"' + @lyric.title + '".'
      redirect_back(fallback_location: root_path)
    else
      render template: 'lyrics/show'
    end
  end

  def apply_params
    params.require(:request).permit(:comments)
  end
end
