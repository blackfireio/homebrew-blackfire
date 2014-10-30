require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp54 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.15.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.15.1-darwin_amd64-php54.tar.gz'
    sha1 'b55fd16078a751db1ec3095d4d99569d166e7030'

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<-EOS.undent
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
        blackfire.agent_timeout = 0.25
        ;blackfire.log_level = 3
        ;blackfire.log_file = /tmp/blackfire.log
        ;blackfire.server_id =
        ;blackfire.server_token =
        EOS
    end
end
