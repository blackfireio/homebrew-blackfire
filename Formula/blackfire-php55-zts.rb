#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.0-darwin_amd64-php55-zts.tar.gz'
    sha256 '6fdd7b6161f3d895db687c67caefcc77c07ec6a6b6aeaf35e139c79ef1c4307a'

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
