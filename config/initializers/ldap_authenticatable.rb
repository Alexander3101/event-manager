require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable
      def authenticate!
        begin
          raise :invalid_params if params[:user].blank?
          @server = get_ldap_server

          @ldap = Net::LDAP.new :host=> @server['host'], :port=> @server['port']
          @ldap.authenticate login.to_s, password.to_s
          raise :invalid_login unless @ldap.bind

          user = User.find_or_create_by_email(login, role: user_role)
          success!(user)
        rescue
          fail($!.inspect)
        end
      end

      private

      def login
        if params[:user][:email].include?('@')
          return params[:user][:email].downcase
        else
         return "#{params[:user][:email]}@#{@server['domain_name']}".downcase
        end
      end

      def password
        params[:user][:password]
      end

      def get_ldap_server
        server_ = nil
        Rails.configuration.ldap['ldap_servers'].each do |server|
          if params[:user][:email].downcase.sub(/.*@/,'') == server[1]['domain_name']
            server_ = server[1]
            break
          end
          if server[1]['default'] == true
            server_ = server[1]
          end
        end
        raise :invalid_config if server_.nil?
        return server_
      end

      def get_user_groups
        search_result = @ldap.search(:base => @server['treebase']) do  |entry|
          return entry[:memberof] if entry[:userprincipalname][0].to_s.downcase == login.to_s
        end
        raise :permission_denied
      end

      def user_role
        user_groups = get_user_groups
        return 'admin' if user_groups.include?(@server['admin_group'])
        return 'user' if user_groups.include?(@server['common_group'])
        raise :permission_denied
      end

    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
