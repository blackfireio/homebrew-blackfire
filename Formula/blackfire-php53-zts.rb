#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.1-darwin_amd64-php53-zts.tar.gz'
    sha256 '4e087fb9c8a9433d8a181185a0a71021c93018c4cf4a9ddfb53e948675e658cc'

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
