class TalkroomsController < ApplicationController
  def show
    @sentroom = Talkroom.find(params[:id])
    @user = User.find(@sentroom.roommate_id)
    @receiveroom = Talkroom.find_by(user_id: @user.id, roommate_id: current_user.id)
    message_read(@receiveroom)
    @message = @sentroom.messages.build
    create_room_list()
    create_message_list()
    counts(@user)
    c_counts()
  end
  
  def create
    user = User.find(params[:roommate_id])
    current_user.talk(user)
    user.talk(current_user)
    flash[:success] = user.name + 'をtakroomを作成しました。'
    @talkroom = Talkroom.find_by(user_id: current_user.id, roommate_id: user.id)
    redirect_to @talkroom
  end

  #def destroy
  #  user = User.find(params[:roommate_id])
  #  current_user.untalk(user)
  #  flash[:secondary] = user.name + 'とのtalkroomを削除しました。'
  #  redirect_back(fallback_location: root_path)
  #end
  
  private
  
  def create_message_list
    if @sentroom && @receiveroom
      @messages = Message.all.where("(talkroom_id = ?) OR (talkroom_id = ?)", @sentroom.id, @receiveroom.id)
    elsif @sentroom
      @messages = Message.all.where(talkroom_id: @sentroom.id)
    elsif @receiveroom  
      @messages = Message.all.where(talkroom_id: @receiveroom.id)
    end
  end
  
  def create_room_list
    @talkrooms = Talkroom.all.where(user_id: current_user.id)
  end
  
  def message_read(receiveroom)
    messages = Message.all.where(talkroom_id: receiveroom.id)
    messages.each do |message|
      unless message.read == true
        message.read = true
        message.save
      end
    end
  end
end
