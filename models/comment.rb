require 'pg'

class Comment

  def initialize(params)
    @params = params
    return unless valid?

    conn.exec("INSERT INTO Comment(text, message) VALUES('#{params[:text]}', #{params[:message]})")
  end

  def valid?
    @params[:text] != ""
  end

  def self.all_by_message(id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("SELECT * FROM Comment WHERE message=#{id};").to_a
  end

  def self.by_id(id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("SELECT * FROM Comment;").to_a[0]
  end

  def self.delete(id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("DELETE FROM Comment WHERE id = '#{id}';")
  end

  def self.delete_by_message(message_id)
    conn = PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
    conn.exec("DELETE FROM Comment WHERE message = '#{message_id}';")
  end

  private

  def conn
    @conn ||= PG.connect :dbname => 'ruby_course', :user => 'ruby', :password => 'password'
  end
end