#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.34.1'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.34.1-darwin_amd64-php55-zts.tar.gz'
    sha256 '04ad782f4f3571f8fd2aa49fb4b8cce5b1f6b17878d0dbe0a7b9c3f24d3181e9'

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

        ;Sets fine-grained configuration for Probe.
        ;This should be left blank in most cases. For most installs,
        ;the server credentials should only be set in the agent.
        ;blackfire.server_id =

        ;Sets fine-grained configuration for Probe.
        ;This should be left blank in most cases. For most installs,
        ;the server credentials should only be set in the agent.
        ;blackfire.server_token =
        EOS
    end
end
