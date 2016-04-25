#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.5'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.5-darwin_amd64-php53-zts.tar.gz'
    sha256 '41ecc88401e44965a5d9500f05a239d7d42f589f80f04813c834e9e02ecceb02'

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
