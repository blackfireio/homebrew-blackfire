#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp55 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.49.0'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.49.0-darwin_amd64-php55.tar.gz'
    sha256 '45b307a5b5e5f434b09bd3e334e8b2409215a73f890b82c7da7a7d9e8a6e53a9'

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
