module ApplicationHelper
  require 'net/http'
  require 'net/https'
  require 'digest/md5'
  require 'json'

  CREDENTIALS_API_KEY    = "<your_api_key>"
  CREDENTIALS_API_SECRET = "<your_api_secret>"
  CREDENTIALS_COMPANY_ID = "<your_company_id>"

  URL_LOGIN = "https://b4.autodesk.com/api/security/v1/login.json"

  def glue_login(login_name, password)
    timestamp = Time.now.getutc.to_i.to_s
    sig = Digest::MD5.hexdigest(CREDENTIALS_API_KEY + CREDENTIALS_API_SECRET + timestamp)
    url = URL_LOGIN

    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
    form_data = {
      :company_id   => CREDENTIALS_COMPANY_ID,
      :api_key      => CREDENTIALS_API_KEY,
      :api_secret   => CREDENTIALS_API_SECRET,
      :timestamp    => timestamp,
      :sig          => sig,
      :login_name   => login_name,
      :password     => password
    }
    request.set_form_data(form_data)

    response = http.request(request)
    return response
  end

end
