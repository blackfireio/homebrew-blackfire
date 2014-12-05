require File.join(File.dirname(__FILE__), 'blackfire-php-extension')

class BlackfirePhp53 < BlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '0.17.2'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_0.17.2-darwin_amd64-php53.tar.gz'
    sha1 '4b2f482be11d0685ab2b174372879add9bef43b3'

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
