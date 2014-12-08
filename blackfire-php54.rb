require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp54 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.17.4'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.17.4-darwin_amd64-php54.tar.gz'
    sha1 'c606252724063a3415b12f2df710b9f23e9a5dc8'

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
