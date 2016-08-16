#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.12.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.12.0-darwin_amd64-php56-zts.tar.gz'
    sha256 'f3221c2ea37378e5e271eb9147cd66efaa5a1da50dda92b9e48b25e2239b0f94'

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
