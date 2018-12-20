require 'net/https'
require 'uri'

class ChatworkController < ApplicationController
  BASE_ENDPOINT = 'https://api.chatwork.com/v2'
  API_TOKEN = '53e170e0e6e1e83989b0672904df3129'

  def show
    # 自分の情報
    get_from_chatwork('me')
    # コンタクト一覧
    # get_from_chatwork('contacts')
    # チャットルームに参加しているメンバー情報の取得
    # get_from_chatwork('rooms/xxxxx/members')
  end

  def send_message
  end

  private
  def get_from_chatwork(endpoint)
    uri = URI.parse("#{BASE_ENDPOINT}/#{endpoint}")
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true if uri.scheme == 'https'

    req = Net::HTTP::Get.new(uri.path)
    req['X-ChatWorkToken'] = API_TOKEN

    res = http.request(req)

    logger.debug "Response [#{res.code}] #{res.msg}"
    if res.body.present?
      logger.debug JSON.parse(res.body)
      JSON.parse(res.body)
    end
  end

  def send_to_chatwork(room_id, message)
    uri = URI.parse("#{BASE_ENDPOINT}/rooms/#{room_id}/messages")
    http = Net::HTTP.new(uri.host, uri.port)

    if uri.scheme == 'https'
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end

    req = Net::HTTP::Post.new(uri.path)
    req['X-ChatWorkToken'] = API_TOKEN
    req.set_form_data({ body: message })

    res = http.request(req)
  end
end

# 自分の情報
# {
# 	"account_id"=>3570000, 
# 	"room_id"=>135970000, 
# 	"name"=>"山田 太郎", 
# 	"chatwork_id"=>"", 
# 	"organization_id"=>2350000, 
# 	"organization_name"=>"", 
# 	"department"=>"", 
# 	"title"=>"", 
# 	"url"=>"", "introduction"=>"", 
# 	"mail"=>"", 
# 	"tel_organization"=>"", 
# 	"tel_extension"=>"", 
# 	"tel_mobile"=>"", 
# 	"skype"=>"", 
# 	"facebook"=>"", 
# 	"twitter"=>"", 
# 	"avatar_image_url"=>"https://appdata.chatwork.com/avatar/ico_default_red.png", 
# 	"login_mail"=>"0000@gmail.com"
# }

# チャットルーム参加者の一覧は以下の情報が取得出来る
# [{
# 	"account_id"=>3570000, 
# 	"role"=>"admin", 
# 	"name"=>"山田 太郎", 
# 	"chatwork_id"=>"", 
# 	"organization_id"=>2350000, 
# 	"organization_name"=>"", 
# 	"department"=>"", 
# 	"avatar_image_url"=>"https://appdata.chatwork.com/avatar/ico_default_red.png"
# }, {
# 	"account_id"=>3570000, 
# 	"role"=>"member", 
# 	"name"=>"アシスタント１", 
# 	"chatwork_id"=>"", 
# 	"organization_id"=>2350000, 
# 	"organization_name"=>"", 
# 	"department"=>"", 
# 	"avatar_image_url"=>"https://appdata.chatwork.com/avatar/ico_default_violet.png"
# }]

# コンタクト一覧は以下の情報が取得出来る
# [{
# 	"account_id"=>3570000, 
# 	"room_id"=>135970000, 
# 	"name"=>"アシスタント１", 
# 	"chatwork_id"=>"", 
# 	"organization_id"=>2350000, 
# 	"organization_name"=>"", 
# 	"department"=>"", 
# 	"avatar_image_url"=>"https://appdata.chatwork.com/avatar/ico_default_violet.png"
# }]
