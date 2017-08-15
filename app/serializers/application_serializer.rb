class ApplicationSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpders
  # 共通のURLを設定可能
  #default_url_options[:host] = ''
end