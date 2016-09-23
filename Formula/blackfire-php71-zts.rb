#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp71Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.13.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.13.0-darwin_amd64-php71-zts.tar.gz'
    sha256 '95b3a189e7d2ba995a66d1676fcb953a4b953062b3105e82cd7e9751f86f25ce'

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
