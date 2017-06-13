#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.17.2'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.17.2-darwin_amd64-php53.tar.gz'
    sha256 '20d14ec8c4cfec9f370e37043e35afbd2c9b3fe3649aad6d84d98e7802e70338'

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
