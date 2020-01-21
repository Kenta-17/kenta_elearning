class Admin::WordsController < ApplicationController
  before_action :required_login, :admin_user

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words
  end

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
    3.times { @word.choices.build }
  end

  

  def create
    @category = Category.find(params[:category_id])
    @word = @category.words.build(words_params)

    if @word.save
      flash[:success] = "Successfully Created"
      redirect_to admin_category_words_url
    else
      render 'new'
    end

  end

  def edit
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
  end


  def update
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
    if @word.update_attributes(words_params)
      flash[:success] = "Successfully changed"
      redirect_to admin_category_words_url
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @word = Word.find(params[:id])
    @word.destroy
    flash[:success] = "Successfully deleted"
    redirect_to admin_category_words_url
  end

  private
   def words_params
    params.require(:word).permit(:content, choices_attributes: [:id, :content, :correct])
   end
end
