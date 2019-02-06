class SubsController < ApplicationController
  before_action :logged_in?
  before_action :is_moderator?, only: [:edit, :update]

  def new
    @sub = Sub.new
    render :new
  end 

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else 
      redirect_to new_sub_url
    end 
  end 

  def index 
    @subs = Sub.all 
    render :index 
  end 
  
  def show
    @sub =  Sub.find(params[:id])
    render :show
  end 

  def edit
    @sub = current_user.subs.find(params[:id])
    render :edit
  end 

  def update
    @sub = current_user.subs.find(params[:id])
    @sub.update_attributes(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url(@sub)
    end

  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def is_moderator?(sub)
    self.current_user.id == sub.moderator_id
  end 

end
