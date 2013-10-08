class Chapter < ActiveRecord::Base
  has_many :ratings
  belongs_to :stories
end
