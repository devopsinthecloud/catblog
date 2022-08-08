class ArticlesController < ApplicationController
  before_action :authorize, only: [:edit, :update]
  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Article.all
  end

  def show
    require "google/cloud/bigquery"
    @article = Article.find(params[:id])
    @service = Google::Cloud::Bigquery.new(
      project_id: "playground-355706",
      scope: [
        'https://www.googleapis.com/auth/bigquery.readonly',
        'https://www.googleapis.com/auth/bigquery.insertdata'
      ]
    )
    dataset = @service.dataset "dataset"
    table = dataset.table "tatatable"
    rows = [
        {
            "first_name" => "Anna",
            "last_name" => "Jenkins",
            "email" => "test@gmail.com",
            "gender" => "Female",              
            "ip_address" => "0.0.0.0"
        }
    ]
    table.insert rows
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end

end
