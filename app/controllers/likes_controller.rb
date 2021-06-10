class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(like_params)
    flash[:alert] = @like.errors.full_messages.join(', ') unless @like.save
    respond_to do |format|
      format.js { render 'toggle.js.erb' }
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    flash[:alert] = @like.errors.full_messages.join(', ') unless @like.destroy
    respond_to do |format|
      format.js { render 'toggle.js.erb' }
    end
  end

  protected

  def like_params
    params.permit(:likeable_id, :likeable_type)
  end
end
