class MessagesController < ApplicationController
  def create
    @sentroom = Talkroom.find(params[:talkroom_id]) 
    @message = @sentroom.messages.build(message_params)
    @message.read = false
    if @message.save
      flash[:success] = 'メッセージを投稿しました。'
    else
      @message = @sentroom.messages.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
    end
    redirect_back(fallback_location: root_path)
  end

  def dstroy
  end
  
  private
  
  def message_params
    params.require(:message).permit(:content)
  end
end
