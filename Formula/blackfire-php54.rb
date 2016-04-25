#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.5'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.5-darwin_amd64-php54.tar.gz'
    sha256 '7b686a1a85dc8eb4c753f2d51324a09b111747e49daf08b1085a85bbf5a1740e'

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
