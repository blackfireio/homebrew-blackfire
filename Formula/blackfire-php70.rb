#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp70 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.20.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.20.0-darwin_amd64-php70.tar.gz'
    sha256 '191b45da3e4d39d7a8af38150239d4e626dfd7a2a14cd5776b37d9d7a4f060aa'

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
