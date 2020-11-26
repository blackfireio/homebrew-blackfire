#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.46.4'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.46.4-darwin_amd64-php55.tar.gz'
    sha256 '566808c0733c5aa962c02959a0ffe379be0f52d2cd6cbe1692a08a6de897b18a'

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<~EOS
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
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
