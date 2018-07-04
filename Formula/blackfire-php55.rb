#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.22.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.22.0-darwin_amd64-php55.tar.gz'
    sha256 '6137d13f64277c61df87d2b9e179438677b376cb5e28bc0252ae5097f568608f'

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
