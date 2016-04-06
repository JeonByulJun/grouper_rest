class WhiteboardController < ApplicationController
  def update
    @whiteboard = Whiteboard.find(params[:whiteboardid])
    @whiteboard.content = params[:content]
    @chat = @whiteboard.chat
    @whiteboard.edit = false
    if @whiteboard.save
      @message = Message.new(:content => "Whiteboard has been Changed")
      @message.user = current_user
      @message.chat = @whiteboard.chat
      @message.save
      sync_new @message, scope: @chat, partial: 'newmessages'
      sync_update @whiteboard, scope: @chat

    end


  end

  def update2
    @whiteboard = Whiteboard.find(params[:whiteboardid])
    @whiteboard.user = current_user
    if @whiteboard.edit != true
      @whiteboard.edit = true
      if @whiteboard.save
        sync_update @whiteboard, scope: @chat
      end
    end
  end
end
