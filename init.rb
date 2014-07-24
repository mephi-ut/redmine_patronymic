require "user_patch"

Redmine::Plugin.register :patronymic do
  name 'Patronymic plugin'
  author 'Dmitry Yu Okunev'
  description 'Adds "lastname"+"firstname"+"patronymic" user display name format'
  version '0.0.1'
  url 'https://github.com/mephu-ut/redmine_patronymic'
  author_url 'https://github.com/xaionaro'
end

