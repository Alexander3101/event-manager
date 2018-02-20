EN:
  TO DO
RU:
  Для включения ldap авторизации, необходимо создать файл /config/ldap.yml следующего содержания:

  development:
    ldap_servers:
      main:
        host: example.com
        port: 389
        domain_name: example.com  # login@example.com
        default: true
        treebase: ou=User Accounts,dc=example,dc=com
        admin_group: OU=Admins,DC=example,DC=com
        common_group: OU=Groups,DC=example,DC=com
      secondary:
        host: secondary.example.com
        port: 389
        domain_name: secondary.example.com
        default: false
        treebase: ou=User Accounts,dc=example,dc=com
        admin_group: OU=Admins,DC=example,DC=com
        common_group: OU=Groups,DC=example,DC=com
