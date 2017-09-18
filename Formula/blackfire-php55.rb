#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.18.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.18.0-darwin_amd64-php55.tar.gz'
    sha256 'c7e3b0b6a7d41e6c0f10d4c4b8fd3ff01d3ac0e4e47ae6426063f7a88ce310c6'

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
