class MessagesController < ApplicationController

  before_action :require_user

  def create
    @message = Message.new(message_params)
    @message.chef = current_chef
    if @message.save
      ActionCable.server.broadcast "chatroom", render(partial: 'messages/message', object: @message)
    else
      render 'chatrooms/show'
    end
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end

end
