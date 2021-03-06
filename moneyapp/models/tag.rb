require_relative '../db/SqlRunner'
require 'pry-byebug'

class Tag

  attr_accessor :id, :name

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
  end

  def self.all()
    sql = "SELECT * FROM tags;"
    tags = SqlRunner.run(sql)
    return tags.map {|options| Tag.new(options)}
  end

  def save()
    sql = "INSERT INTO tags (name) VALUES ('#{@name}') returning *;"
    result = SqlRunner.run(sql)
    @id = result[0]['id'].to_i()
  end

  def self.find(id)
    sql = "SELECT * FROM tags WHERE id = #{id};"
    tag = SqlRunner.run(sql)
    result = Tag.new(tag.first)
    return result
  end

  def update(options)
    sql = "UPDATE tags SET
      name = '#{ options['name'] }'  
      WHERE id = '#{ options['id'] }';"
    SqlRunner.run( sql )
  end

  def delete()
    sql = "DELETE FROM tags WHERE id=#{ @id };"
    SqlRunner.run( sql )
  end

end