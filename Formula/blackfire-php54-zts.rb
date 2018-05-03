#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.0-darwin_amd64-php54-zts.tar.gz'
    sha256 'b2e8215a190692d9c7af41cd9e48ef63feaca305b8e788e4f0b4f599881e49f6'

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<~EOS
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
        blackfire.agent_timeout = 0.25
        ;blackfire.log_level = 3
        ;blackfire.log_file = /tmp/blackfire.log
        ;blackfire.server_id =
        ;blackfire.server_token =
        EOS
    end
end
