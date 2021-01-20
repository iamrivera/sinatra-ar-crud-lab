
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
   redirect "/articles/#{@article.id.to_s}"    
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
    updated_params = params.tap {|p| p.shift}
    @article.update(updated_params)
    # @article.title = params["title"]
    # @article.content = params["content"]
    # @article.save #try again to get .update to work
    redirect "/articles/#{@article.id.to_s}"
  end
  
  delete '/articles/:id' do
    Article.find(params["id"]).destroy
   
    redirect '/articles'
  end

end
