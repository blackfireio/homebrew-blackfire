#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.16.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.16.0-darwin_amd64-php55-zts.tar.gz'
    sha256 '5d9160677ff95017af0fae04e2d5d0a25f605f8da619128d46c3139c5b04002b'

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
