class ApplicationController < ActionController::Base
  include SessionsHelper

  def required_login
    unless signed_in?
      flash[:danger] = 'Please login first'
      redirect_to signin_url
    end
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = 'You are not admin user'
      redirect_to dashboard_url
    end
  end
end
