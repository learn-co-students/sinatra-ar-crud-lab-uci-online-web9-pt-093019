
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    title = params[:title]
    content = params[:content]
    @article = Article.new
    @article.title = title
    @article.content = content
    @article.save
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  delete '/articles/:id' do
    Article.delete(params[:id])
    redirect '/articles'
  end

  patch '/articles/:id' do
    @article = Article.find(params[:id])
    @article.content = params[:content]
    @article.title = params[:title]
    @article.save
    redirect "/articles/#{Article.last.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end


end
