class Resource < ActiveRecord::Base
end

# == Schema Information
#
# Table name: resources
#
#  id                      :integer(4)      not null, primary key
#  title                   :string(255)
#  description             :text
#  link                    :string(255)
#  resource_type_id        :integer(4)
#  business_id             :integer(4)
#  created_at              :datetime
#  updated_at              :datetime
#  attachment_file_name    :string(255)
#  attachment_content_type :string(255)
#  attachment_file_size    :integer(4)
#  attachment_updated_at   :datetime
#

