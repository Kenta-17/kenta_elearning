class Admin::WordsController < ApplicationController
  before_action :required_login, :admin_user

  def index
    @category = Category.find(params[:category_id])
    @words = @category.words
  end

  def new
    @category = Category.find(params[:category_id])
    @word = @category.words.build
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
    @word = Word.find(params[:id])
  end


  def update
  end

  def update
  end

  private
   def words_params
    params.require(:word).permit(:content)
   end
end
