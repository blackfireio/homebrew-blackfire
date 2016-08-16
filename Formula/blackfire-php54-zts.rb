#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.12.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.12.0-darwin_amd64-php54-zts.tar.gz'
    sha256 '32ff844b8709cee3d5efb83672ef4a9ed3b2628d4d31bb71fe7c072c47a9c966'

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
