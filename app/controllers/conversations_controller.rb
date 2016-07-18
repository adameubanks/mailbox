class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Converation.all
  end

  def create
    if Converation.between(params[:sender_id], params[:recipient_id]).present?
      @converation = Converation.between(params[:sender_id], params[:recipient_id]).first
    else
      @converation = Converation.create!(converation_params)
    end
    redirect_to converation_messages_path(@converation)
  end

  private
  def converation_params
    params.permit(:sender_id, :recipient_id)
  end
end
