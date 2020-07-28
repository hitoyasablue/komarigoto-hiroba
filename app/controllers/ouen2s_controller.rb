class Ouen2sController < ApplicationController
  include SessionsHelper

  def create
    ouen2 = Ouen2.new(user_id: current_user.id, progress_id: params[:progress_id])
    ouen2.save
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
    # @progress.create_notification_ouen2!(current_user)
  end

  def destroy
    ouen2 = Ouen2.find_by(user_id: current_user.id, progress_id: params[:progress_id])
    ouen2.destroy
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
  end
end
