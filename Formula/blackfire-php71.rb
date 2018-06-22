#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp71 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.21.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.21.0-darwin_amd64-php71.tar.gz'
    sha256 '1558430215aab1e761e21049c752a681d426fd65dbc6e6ee3b3fce5f741a4afe'

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
