json.array! @messages do |message|
  json.user_name  message.user.name
  json.data       message.created_at.to_s
  json.text       message.text
  json.image      message.image_url
  json.id         message.id
end