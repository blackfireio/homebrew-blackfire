#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp56 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.4'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.4-darwin_amd64-php56.tar.gz'
    sha256 '11a62ea8a6a09b3dc75114c5c17d6665a3670739a13b5782a92a9399988d2866'

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
