module ApplicationHelper
  def create_redir_link(url, business_id, reference_id, link_type_id)
    "#{DOMAIN_NAMES[Rails.env]}/redir/?url=#{CGI::escape(url)}&bId=#{business_id.to_s}&rId=#{reference_id.to_s}&tId=#{link_type_id.to_s}&pId=0"
  end
end
