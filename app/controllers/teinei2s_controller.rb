class Teinei2sController < ApplicationController
  include SessionsHelper

  def create
    teinei2 = Teinei2.new(user_id: current_user.id, progress_id: params[:progress_id])
    teinei2.save
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
    @progress.create_notification_teinei2!(current_user)
  end

  def destroy
    teinei2 = Teinei2.find_by(user_id: current_user.id, progress_id: params[:progress_id])
    teinei2.destroy
    @user = User.find_by(id: current_user.id)
    @progress = Progress.find_by(id: params[:progress_id])
  end
end
