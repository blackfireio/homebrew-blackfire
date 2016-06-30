#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.11.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.11.1-darwin_amd64-php56-zts.tar.gz'
    sha256 'e36826ee616d6e9f9c8e2487dd9dcfedfff094f7f4f895e729d6edc7fb10d10c'

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
