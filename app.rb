require 'debug'
require "awesome_print"
require 'sinatra'
require 'sinatra/base'
require 'sqlite3'

class App < Sinatra::Base

    setup_development_features(self)

    # Funktion för att prata med databasen
    # Exempel på användning: db.execute('SELECT * FROM fruits')
  def db
      return @db if @db
      @db = SQLite3::Database.new(DB_PATH)
      @db.results_as_hash = true

      return @db
  end

  # Routen /

  get '/' do
    "Hello World"
  end

  get '/clothing' do 
        @clothing = db.execute('SELECT * FROM clothing ORDER BY name')
      p @clothing
      erb(:"index")
  end

  post '/clothing/:id/delete' do | id |
        db.execute('DELETE FROM clothing WHERE id= ' +id)
      redirect ('/clothing')
  end
 
  get '/clothing/:id/edit' do | id |
      p params
      cloth_name = params["cloth_name"]
      cloth_description = params["cloth_description"]

      @cloth = db.execute('SELECT * FROM clothing WHERE id=?', id).first 
    
      erb :'/edit'
   
  end

  post "/clothing/:id/update" do | id |
    p params
    c_name = params["cloth_name"]
    c_category = params["cloth_description"]
    db.execute("UPDATE clothing SET name =?, description=? WHERE id =?", [c_name, c_category, id])

    redirect("/clothing")
  end
end
