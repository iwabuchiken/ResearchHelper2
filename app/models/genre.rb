class Genre < ActiveRecord::Base
  has_many :article
end
