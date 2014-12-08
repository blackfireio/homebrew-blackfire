require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp56 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.17.4'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.17.4-darwin_amd64-php56.tar.gz'
    sha1 '5f261a1824cca7a49384bc4961e9ba3620f38eb2'

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
