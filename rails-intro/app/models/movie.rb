class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date, :sort, :all_ratings
  def self.all_ratings; ['G','PG','PG-13','R']; end
end
