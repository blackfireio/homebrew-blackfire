#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.3'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.3-darwin_amd64-php53-zts.tar.gz'
    sha256 '9c72310761bfac65ab0bcc3f588e89b5db4a51f267f6d75c5d662e1b5218cb0b'

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
