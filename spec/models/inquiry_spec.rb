require 'spec_helper'

describe Inquiry do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: inquiries
#
#  id          :integer(4)      not null, primary key
#  name        :string(255)
#  email       :string(255)
#  details     :text
#  business_id :integer(4)
#  is_archived :boolean(1)      default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#

