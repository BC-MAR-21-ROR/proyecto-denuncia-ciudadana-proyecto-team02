class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    if @like.save
      flash[:success] = 'Thanks for liking!'
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
    end
    redirect_to root_path(anchor: "denounce_#{@like.likeable_id}")
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if @like.destroy
      flash[:success] = "Un like #{@like.likeable_type}!"
    else
      flash[:alert] = @like.errors.full_messages.join(', ')
    end
    redirect_to root_path(anchor: "denounce_#{@like.likeable_id}")
  end

  protected

  def like_params
    params.permit(:likeable_id, :likeable_type)
  end
end
