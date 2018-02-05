require_relative "config/application"

require "sinatra"
require "sinatra/reloader"
require "sinatra/activerecord"

set :database, { adapter: "sqlite3", database: "db/development.sqlite3" }
set :views, Proc.new { File.join(root, "app/views") }

# Routes + Controller

get '/' do
  @restaurants = Restaurant.all # Array<Restaurant>
  erb :index  # Embedded Ruby
end

get '/restaurants/new' do
  erb :new
end

post '/restaurants/create' do
  name = params[:name]
  description = params[:description]

  restaurant = Restaurant.new(name: name, description: description)
  restaurant.save
  redirect to("/")
end

# "restaurants/2"
# "restaurants/1"
# "restaurants/5"
get '/restaurants/:id' do
  id = params[:id] # params is an hash that has allllllllllll the input from the browser
  @restaurant = Restaurant.find(id)
  erb :show
end

get '/about' do
  erb :about
end
