#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.22.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.22.0-darwin_amd64-php56-zts.tar.gz'
    sha256 '7c06d12a0e9d17489b9f6dfd7d20ae59f6c325a256938523ad48ab50c1a50f9b'

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
