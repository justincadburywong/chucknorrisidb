class Joke < ActiveRecord::Base
  serialize :categories, Array
  validates :joke, :categories, presence: true, allow_nil: false
end
