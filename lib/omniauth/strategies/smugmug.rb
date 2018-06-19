require 'omniauth-oauth'
require 'multi_json'

module OmniAuth
  module Strategies
    class SmugMug < OmniAuth::Strategies::OAuth
      option :name, 'smugmug'
      option :client_options, {
        :site => 'https://api.smugmug.com',
        :request_token_path => "/services/oauth/getRequestToken.mg",
        :access_token_path  => "/services/oauth/getAccessToken.mg",
        :authorize_path     => "/services/oauth/authorize.mg"
      }

      uid { user['id'] }

      info do
        {
          'uid' => user['id'],
          'nickname' => user['NickName'],
          'name' => user['Name'],
          'urls' => {
              'website' => user['URL'],
          }
        }
      end

      extra do
        { 'user_hash' => user }
      end

      def user
        @user_hash ||= MultiJson.decode(@access_token.get('https://api.smugmug.com/services/api/json/1.3.0/?method=smugmug.auth.checkAccessToken').body)['Auth']['User']
      end

      def request_phase
        options[:authorize_params] = {
          Access: options['access'],
          Permissions: options['permissions']
        }
        super
      end

    end
  end
end

OmniAuth.config.add_camelization 'smugmug', 'SmugMug'
