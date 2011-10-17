Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, "HjzVzzin2zCogq8tNezeA", "oiD9D0lJROgl6giJ3UofU1iRZEGCIHOBXD8t9VVB01o"
  provider :linked_in, "694wVPqtdE2lQmrRRJ2YG-uxoVA-f1E6Cb6cPUdxe2xUMcwuaq4D0wgmcdwAoucg", "0tY-2DGwi0w1MbtitnV1I9PIjdOUqyDoVSNxWspucm0ZfziRJmAxHB_Dqwi1m_zM"
  provider :facebook, "164486726974185", "ee561cefebfa7ed6165934401e9b4141", {:scope => "publish_stream,offline_access,email"}
end

Twitter.configure do |config|
  config.consumer_key = "HjzVzzin2zCogq8tNezeA"
  config.consumer_secret = "oiD9D0lJROgl6giJ3UofU1iRZEGCIHOBXD8t9VVB01o"
  config.oauth_token = "79022077-J3VPDE1rHrsVxjHyxMnQp8elzmZR8sgG0uSuQBcFZ"
  config.oauth_token_secret = "XrG8rOVnISgsuHSmymLGSNpcHeWyvig5iWMjv2QQ"
end