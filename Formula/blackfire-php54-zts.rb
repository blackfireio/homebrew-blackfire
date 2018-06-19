#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.1-darwin_amd64-php54-zts.tar.gz'
    sha256 '03c7f4664ba33c9409b9396327088c70fd0e310a89e0ef106483b96f9d2bfe89'

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
