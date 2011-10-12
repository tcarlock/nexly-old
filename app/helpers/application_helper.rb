module ApplicationHelper
  def create_redir_link(url)
    DOMAIN_NAME + "/open_popup?url=" + CGI::escape(url)
  end
end
