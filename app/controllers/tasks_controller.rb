class TasksController < ApplicationController
  before_action :authenticate_user!

  def create
    if custom_user_authentication_else(Team.find(params[:team])) && params[:user_ids]
      @task = Task.new(:taskname => params[:taskname], :duedate => params[:duedate])
      @task.users << User.where(:id => params[:user_ids])
      @task.sender = current_user.id
      @task.wansungdo = 0
      @task.team_id = params[:team]
      if @task.save
        redirect_to action: 'index', controller: 'chats', team: params[:team]
      end
    else
      redirect_to action: 'index', controller: 'chats', team: params[:team]
    end
  end

  def index
    task1 = Task.where(:sender => current_user.id)
    @tasksend = task1.where(:team_id => params[:team]).order(duedate: :asc)
    task2 = current_user.tasks
    @taskdo = task2.where(:team_id => params[:team])
    @task100 = task2.where(:wansungdo => 100, :team_id => params[:team]).order(duedate: :asc)
    @tasklist = @taskdo.order(duedate: :asc)
    @tasklistdesc = @taskdo.order(duedate: :desc)
    @team = Team.find(params[:team])
    custom_user_authentication_show(@team)

    @chats = current_user.chats.where(:team => params[:team])
  end
=begin
  def entire
    @managelist = Task.order(duedate: :asc)
    @managelistdesc = Task.order(duedate: :desc)
    @team = Team.find(params[:team])
    @teamtask = Task.where(:team_id => params[:team])
    custom_user_authentication_show(@team)

  end
=end
  def wansungdo_update
    @task = Task.find(params[:task_id])
    @task.wansungdo = params[:wansungdo]
    @comment = Comment.create(task_id: params[:task_id], wansungdo_log: params[:wansungdo], comment_log: params[:comment])
    @task.comments << @comment
    if custom_user_authentication_else(@task.team) && @task.save
      redirect_to tasks_path(team: params[:team_id])
    end
  end
end
