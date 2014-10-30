require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp56 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.15.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.15.1-darwin_amd64-php56.tar.gz'
    sha1 'cd303c580ee21c7ef46ee79c9be7064017b14af2'

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
