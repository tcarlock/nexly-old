class Suggestion < ActiveRecord::Base
  validates_presence_of :details, :message => "Please complete this field"
end

# == Schema Information
#
# Table name: suggestions
#
#  id         :integer(4)      not null, primary key
#  details    :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

