class Admin::PagesController < ApplicationController
  before_action :required_login, :admin_user
 
  def home
  end
  
end
