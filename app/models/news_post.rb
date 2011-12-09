class NewsPost < ActiveRecord::Base
	belongs_to :business

	validates_presence_of :title, :content, :message => "Required field", 
end
