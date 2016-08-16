#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp53Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.12.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.12.0-darwin_amd64-php53-zts.tar.gz'
    sha256 '7e1e705fac79f0888f47d48512d05e1732c4ea40e361397068fb05f8a75a8f41'

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
