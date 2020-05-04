module TalkroomsHelper
  
  def counts_unread(receiveroom)
    count = 0
    @messages = Message.where(talkroom_id: receiveroom.ids)
    @messages.each do |message|
      unless message.read == true
        count += 1
      end
    end
    return count
  end
  
  def counts_unread_oneroom(sentroom)
    @receiveroom = Talkroom.find_by(user_id: sentroom.roommate_id, roommate_id: current_user.id)
    if @receiveroom
      count = 0
      @messages = Message.where(talkroom_id: @receiveroom.id)
      @messages.each do |message|
        unless message.read == true
          count += 1
        end
      end
    end
    return count
  end
end
