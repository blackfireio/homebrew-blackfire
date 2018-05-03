#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.0-darwin_amd64-php54.tar.gz'
    sha256 'a6686a47bd888c0a6a5b2fb73b52a4f15282068030798be96ab90d5abb4185da'

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
