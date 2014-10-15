require 'pry'

class ActiveRecord
  def initialize
    @@objects ||= []
    @@objects << self
  end

  def self.all
    @@objects
  end
end


class Post < ActiveRecord
  attr_accessor :title

  def initialize(title)
    @title = title
    super()
  end
end


binding.pry