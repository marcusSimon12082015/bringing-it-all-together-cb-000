class Dog
  attr_accessor :id,:name,:breed

  def initialize(name:,breed:,id:nil)
    @name = name
    @breed = breed
    @id = id
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS dogs(id INTEGER PRIMARY KEY,name INTEGER,breed TEXT)
    SQL
    DB[:conn].execute(sql)
  end
  def self.drop_table
    sql = <<-SQL
      DROP TABLE IF EXISTS dogs
    SQL
    DB[:conn].execute(sql)
  end
  def save
    sql = <<-SQL
      INSERT INTO dogs(name,breed) VALUES(?,?)
    SQL
    DB[:conn].execute(sql,self.name,self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end
  def self.create(hash)
    dog = Dog.new(name:nil,breed:nil)
    hash.each do |key,value|
      dog.send("#{key}=",value)
    end
    dog.save
    dog
  end
  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    row = DB[:conn].execute(sql,id)[0]
    Dog.new(row[0],row[1],row[2])
  end
end
