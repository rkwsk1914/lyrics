class MessagesController < ApplicationController
  def create
    @sentroom = Talkroom.find(params[:talkroom_id]) 
    @message = @sentroom.messages.build(message_params)
    @message.read = false
    if @message.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_back(fallback_location: root_path)
    else
      @message = @sentroom.messages.all.page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def dstroy
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end
