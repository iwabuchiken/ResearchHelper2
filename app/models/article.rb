class Article < ActiveRecord::Base
  has_many :memo
  belongs_to :genre
  
end
