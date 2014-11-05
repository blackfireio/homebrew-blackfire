require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp54 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.16.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.16.0-darwin_amd64-php54.tar.gz'
    sha1 '3e8c9de6b6f701600803d7cb1715964d1eec86f1'

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
