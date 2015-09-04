#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.3.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.3.0-darwin_amd64-php56.tar.gz'
    sha1 '14fdd516bea7770485d6b7a4a69eddd8255e8fae'

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
