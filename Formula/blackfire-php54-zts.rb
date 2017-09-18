#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp54Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.18.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.18.0-darwin_amd64-php54-zts.tar.gz'
    sha256 '57c9fb65a29d52eaed1cd516ca000d814e7cd5a8334b9b9335606b9c419c765b'

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
