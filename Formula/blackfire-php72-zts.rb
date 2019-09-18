#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp72Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.27.1'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.27.1-darwin_amd64-php72-zts.tar.gz'
    sha256 '273a17647d4a8e0cbc98b029ec27518bcafbd7f49c6dac8084d7cfc6e3a6df9c'

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
