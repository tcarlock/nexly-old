Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "HjzVzzin2zCogq8tNezeA", "oiD9D0lJROgl6giJ3UofU1iRZEGCIHOBXD8t9VVB01o"
  provider :linked_in, "694wVPqtdE2lQmrRRJ2YG-uxoVA-f1E6Cb6cPUdxe2xUMcwuaq4D0wgmcdwAoucg", "0tY-2DGwi0w1MbtitnV1I9PIjdOUqyDoVSNxWspucm0ZfziRJmAxHB_Dqwi1m_zM"
  provider :facebook, "164486726974185", "ee561cefebfa7ed6165934401e9b4141", {:scope => "publish_stream,offline_access,email,manage_pages"}
  provider :openid, nil, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
end