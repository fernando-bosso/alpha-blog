class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  self.per_page=3
  

  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)    
  end

  def new 
    @article = Article.new  
  end 

  def edit
  end

  def show
    
  end

  def destroy
    
    @article.destroy
    flash[:success] = "succesfully deleted!"
    redirect_to articles_path
  end


  def create
    @article = Article.new(article_params)
    @article.user = User.first
    if @article.save
      flash[:success] = "Article was succesfully created!"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    end
  end



  private
  def article_params
    params.require(:article).permit(:title,:description)
  end

  def set_article
    @article = Article.find(params[:id])
  end



end