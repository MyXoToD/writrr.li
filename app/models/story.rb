class Story < ActiveRecord::Base
  has_many :chapters
  belongs_to :users
end
