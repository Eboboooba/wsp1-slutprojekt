require 'debug'
require "awesome_print"

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
    get '/clothing' do 
        @clothing = db.execute('SELECT * FROM clothing ORDER BY name')
      p @clothing
      erb(:"index")
    end

    post '/clothing/:id/delete' do | id |
        db.execute('DELETE FROM clothing WHERE id= ' +id)
      redirect ('/clothing')
    end

end
