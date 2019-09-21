class SearchForm 
  include ActiveModel::Model

  attr_accessor :horse_name
  validates :horse_name, presence: true
end