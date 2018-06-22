#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.21.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.21.0-darwin_amd64-php55-zts.tar.gz'
    sha256 'bfacdd41e657a5a6640b00a22a3737bff35e1cc5f7f10e508e9e71f081692c58'

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
