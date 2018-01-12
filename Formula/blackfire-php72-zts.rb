#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp72Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.18.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.18.1-darwin_amd64-php72-zts.tar.gz'
    sha256 'ad8e57fc5bb7fd5296e0333eeb2a62522a0b26f489eebdeb8e71917420fa15f8'

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
