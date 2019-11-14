require 'pg'

class Message

  def initialize(params)
    @params = params
    return unless valid?

    conn.exec("INSERT INTO Message(text) VALUES('#{params[:text]}')")
  end

  def valid?
    @params[:text] != ""
  end

  def self.all
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("SELECT * FROM Message;").to_a
  end

  def self.by_id(id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("SELECT * FROM Message WHERE id = #{id};").to_a[0]
  end

  def self.delete(id)
    Comment.delete_by_message(id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("DELETE FROM Message WHERE id = '#{id}';")
  end

  private

  def conn
    @conn ||= PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
  end
end