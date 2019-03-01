require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns if @columns
    columns = DBConnection.execute2(<<-SQL).first 
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    @columns = columns.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |col|
      define_method("#{col}") do 
        attributes[col]
      end

       define_method("#{col}=") do |value|
        attributes[col] = value 
       end 

    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    @table_name ||= self.to_s.tableize
  end

  def self.all
    # ...
   result =  DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    self.parse_all(result)
  end

  def self.parse_all(results)
    # ...
    results.map {|el| self.new(el)}
  end

  def self.find(id)
    # ...
    result =  DBConnection.execute(<<-SQL, id)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE #{self.table_name}.id = ?
      
    SQL
    self.parse_all(result).first
  end

  def initialize(params = {})
    # ...
    params.each do |name, value|
      name = name.to_sym
      if self.class.columns.include?(name)
        self.send("#{name}=", value)
      else
        raise "unknown attribute '#{name}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
    self.class.columns.map {|col| self.send(col)}
  end

  def insert
    # ...
    col_names = self.class.columns.join(',')
    attribute = attribute_values
    questions = (["?"] * attribute.length).join(',')

    DBConnection.execute(<<-SQL, *attribute)
      INSERT INTO
        #{self.class.table_name} (#{col_names})
      VALUES 
        (#{questions})
    SQL

    self.id = DBConnection.last_insert_row_id 
  end

  def update
    # ...
    col_names = self.class.columns.map {|attr| "#{attr} = ?" }.join(", ")
    attribute = attribute_values

    DBConnection.execute(<<-SQL, *attribute, self.id)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = ?
    SQL
  end

  def save
    # ...
    if self.id.nil?
      self.insert
    else
      self.update
    end
  end
end
