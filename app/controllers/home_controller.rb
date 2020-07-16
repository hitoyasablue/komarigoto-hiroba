class HomeController < ApplicationController
  def top
    @post = current_user.posts.build if logged_in?
  end
end
