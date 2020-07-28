class SounandasController < ApplicationController
  include SessionsHelper

  def create
    sounanda = Sounanda.new(user_id: current_user.id, progress_id: params[:progress_id])
    sounanda.save
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
    # @progress.create_notification_sounanda!(current_user)
  end

  def destroy
    sounanda = Sounanda.find_by(user_id: current_user.id, progress_id: params[:progress_id])
    sounanda.destroy
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
  end
end
