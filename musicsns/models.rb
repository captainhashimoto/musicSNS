  require 'bundler/setup'
  Bundler.require

  if development?
    ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
  end

  class Post < ActiveRecord::Base
    belongs_to :user
  end

  class User < ActiveRecord::Base
    has_many :posts
    has_secure_password
  end