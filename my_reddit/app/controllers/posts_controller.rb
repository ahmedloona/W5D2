class PostsController < ApplicationController
  before_action :logged_in?

  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end 

  def create 
    @post = Post.new(post_params)
    @post.author_id = current_user.id 
    if @post.save

      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to new_sub_post_url
    end

  end 

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    @post = current_user.posts.find(params[:id])
    render :edit
  end

  def update
    @post = current_user.posts.find(params[:id])
    @post.update_attributes(post_params)
    if @post.save
      
      redirect_to post_url(@post)
    else
      flash[:errors] = @post.errors.full_messages
      redirect_to edit_post_url
    end   
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids:[])
  end

end
