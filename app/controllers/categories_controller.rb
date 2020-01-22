class CategoriesController < ApplicationController
  def index
    @categories = Category.paginate(page: params[:page], per_page: 6).order('created_at DESC')
  end
end
