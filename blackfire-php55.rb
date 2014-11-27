require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp55 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.17.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.17.1-darwin_amd64-php55.tar.gz'
    sha1 'e1e162f590b266a3fff249b1f6ea46aec120364e'

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
