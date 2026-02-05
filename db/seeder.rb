require 'sqlite3'

class Seeder
  
  def self.seed!
    drop_tables
    create_tables
    populate_tables
  end

  def self.drop_tables
    db.execute('DROP TABLE IF EXISTS clothing')
  end

  def self.create_tables
    db.execute('CREATE TABLE clothing (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                category TEXT,
                description TEXT,
                condition TEXT,
                brand TEXT)')
  end


  def self.populate_tables
    db.execute('INSERT INTO clothing (name, category, description, condition, brand, price) VALUES ("annas tröja", "T-shirt", "En röd t shirt md en blomma på", "gott skick", "HM", "70kr")')
   
  end
  private
  def self.db
    return @db if @db
    @db = SQLite3::Database.new('db/clothing.sqlite')
    @db.results_as_hash = true
    @db
  end
end


Seeder.seed!
