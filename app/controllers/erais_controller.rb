class EraisController < ApplicationController
  include SessionsHelper

  def create
    erai = Erai.new(user_id: current_user.id, progress_id: params[:progress_id])
    erai.save
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
    @progress.create_notification_erai!(current_user)
  end

  def destroy
    erai = Erai.find_by(user_id: current_user.id, progress_id: params[:progress_id])
    erai.destroy
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
  end
end
