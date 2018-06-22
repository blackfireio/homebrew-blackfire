#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp72Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.21.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.21.0-darwin_amd64-php72-zts.tar.gz'
    sha256 'da10de3584db59f98b7584000057046b1b75f90f55b9a3a75594eff0c51b4979'

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
