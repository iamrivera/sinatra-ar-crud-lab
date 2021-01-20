
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
  
  end

  get '/articles' do 
    @article = Article.all 
    erb :index
  end

  get '/articles/new' do 
    
    erb :new
  end

  post '/articles' do 
   @article = Article.create(params)
   id = @article.id
    redirect "/articles/#{id}"    
  end

  get '/articles/:id' do 
    @article = Article.find(params["id"])
    erb :show
  end

  get '/articles/:id/edit' do 
    @article = Article.find(params["id"])
    erb :edit
  end

  patch '/articles/:id'do 
    # binding.pry
    @article = Article.find(params["id"])
    id = @article.id
    @article.title = params["title"]
    @article.content = params["content"]
    @article.save #try again to get .update to work
    redirect "/articles/#{id}"
  end
  
  delete '/articles/:id' do
    @article = Article.find(params["id"])
    @article.destroy
    redirect '/articles'
  end

end
