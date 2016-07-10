class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.new(:title => params[:title])
    @team = Team.find(params[:team])



    if custom_user_authentication_else(@team) && @chat.save
      @team.chats << @chat
      @team.save
      @chat.users << current_user
      @chat.users << User.where(:id => params[:user_ids])
      @chat.whiteboard = Whiteboard.create(:edit => false, :content => "")
      @chat.whiteboard.user = current_user
      @chat.save
      redirect_to action: 'index', team: params[:team]
    else
      redirect_to action: 'index', team: params[:team]

    end
  end
  def index
    @team = Team.find(params[:team])
    custom_user_authentication_show(@team)

    @chats = current_user.chats.where(:team_id => params[:team])
    @managelist = Task.order(duedate: :asc)
    @managelistdesc = Task.order(duedate: :desc)
    @teamtask = Task.where(:team_id => params[:team]).order(duedate: :asc)


  end

  def deletemember
    chat = Chat.find(params[:chat])
    if custom_user_authentication_else(chat)
      chat.users.delete(current_user)
      redirect_to action: 'index', team: params[:team]
    else
      redirect_to :root
    end
  end

  def addmember
    @chat = Chat.find(params[:chat])
    @team = @chat.team

    @chat.users << User.where(:id => params[:user_ids])
    if custom_user_authentication_else(@team) && @chat.save
      redirect_to action: 'index', controller: 'messages', team: params[:team], chat: params[:chat]
    else
      redirect_to action: 'index', controller: 'messages', team: params[:team], chat: params[:chat]
    end
  end


end
