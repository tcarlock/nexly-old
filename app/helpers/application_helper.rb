module ApplicationHelper
  def create_redir_link(url, business_id, reference_id, link_type_id)
    DOMAIN_NAME + "/open_popup?url=" + CGI::escape(url) + "&bId=" + business_id.to_s + "&rId=" + reference_id.to_s + "&tId=" + link_type_id.to_s
  end
  
  def generate_token
    rand(36**8).to_s(36)
  end
end
