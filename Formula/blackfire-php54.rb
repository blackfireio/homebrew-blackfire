#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.2.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.2.0-darwin_amd64-php54.tar.gz'
    sha1 '92a3e72e46f69565f8b103f0768ed376387dfa16'

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
