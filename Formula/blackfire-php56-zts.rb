#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.5'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.5-darwin_amd64-php56-zts.tar.gz'
    sha256 'cd5c38457d6e9949c704723be6e10beba2f0b2ab19a55a897d37ee4df224c54b'

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
