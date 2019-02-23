require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require 'open-uri'
require 'json'
require 'net/http'

require 'sinatra/activerecord'
require './models'

enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user])
  end
end

get '/' do
  erb :index
end

get '/search' do
  erb :search
end

get '/search' do
  uri = URI("https://itunes.apple.com/search")
  uri.query = URI.encode_www_form({
    term :params[:artist],
    method :"get",
    country :"jp",
    media :"music",
    limit :20
  })
  res = Net::HTTP.get_response(uri)
  json = JSON.parse(res.body)
  @musics = json['results']
  erb :search
end

get '/sign_up' do
  erb :sign_up
end

post '/sign_up' do
  user = User.create(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation]
  )
  if user.persisted?
    session[:user] = user.id
  end
  redirect '/'
end

post 'sign_in' do
  user = User.find_by(name: params[:name])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
  end
  redirect '/'
end

get '/signout' do
  session[:user] = nil
  redirect '/'
end

get '/home' do
  erb :home
end

get '/edit/:id' do
  erb :edit
end