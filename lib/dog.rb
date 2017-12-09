class Dog
  attr_accessor :id,:name,:breed

  def initialize(name:,breed:,id:nil)
    @name = name
    @breed = breed
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
end
