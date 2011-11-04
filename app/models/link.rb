class Link < ActiveRecord::Base
  belongs_to :business
  
  validates :in_url, :out_url, :http_status, :presence => true
  validates :in_url, :uniqueness => true
end
