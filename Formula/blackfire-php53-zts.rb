#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.17.2'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.17.2-darwin_amd64-php53-zts.tar.gz'
    sha256 'd169ff3239988cade45c0a4308ed577ef12a2176e5d0362871dd0d8503db7fdc'

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
