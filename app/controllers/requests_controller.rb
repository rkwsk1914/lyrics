class RequestsController < ApplicationController
  def create
    @apply = current_user.requests.new
    @apply.lyric_id = params[:lyric_id]
    @apply.permission = false
    @lyric = Lyric.find(params[:lyric_id])
    
    if @apply.save
      flash[:success] = '『' + @lyric.title + '』の作曲応募しました。/  Applied for composition to "' + @lyric.title + '" !!'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = 'エラー発生！応募に失敗しました。 / Fail Applied for composition!'
      render template: 'lyrics/show'
    end
  end
  
  def edit
    @apply = Request.find(params[:id])
    @lyric = @apply.lyric
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
      flash[:secondary] = '『' + @lyric.title + '』を削除しました。/ Delete "' + @lyric.title + '".'
      redirect_back(fallback_location: root_path)
    else
      render template: 'lyrics/show'
    end
  end

  def comment_params
    params.require(:request).permit(:lyric_id)
  end
end
