class Admin::CategoriesController < ApplicationController
  before_action :required_login, :admin_user

  def index
    @categories = Category.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(categories_params)
    if @category.save
      flash[:success] = "Successfully created"
      redirect_to admin_categories_url
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(categories_params)
      flash[:success] = "Successfully changed"
      redirect_to admin_categories_url
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:success] = "Successfully deleted"
    redirect_to admin_categories_url
  end

  private
    def categories_params
      params.require(:category).permit(:title, :description)
    end

end
