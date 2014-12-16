require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp53 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.18.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.18.0-darwin_amd64-php53.tar.gz'
    sha1 'a7772a936c64cff4a24c2f7dd7ad9fd50ad4f15b'

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
