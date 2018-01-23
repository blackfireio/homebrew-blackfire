#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp72 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.18.2'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.18.2-darwin_amd64-php72.tar.gz'
    sha256 '26f3d63a556fa561740fdd8fd932baf26f6512f1826c52972e2ffc6cf3b6b38f'

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
