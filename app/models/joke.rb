class Joke < ActiveRecord::Base
  serialize :categories, Array
end
