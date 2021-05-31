#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.59.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.59.0-darwin_arm64-php74.tar.gz'
        sha256 'f956ba6fb7d1bceaa9dd32f18ae7d8d71ce83accfdfe4d039906e33ca5ea2136'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.59.0-darwin_amd64-php74.tar.gz'
        sha256 'be8d1eaa4791dc10e9103334fd7574a1098ad8e89060621f56b284fb4ec01c40'
    end

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
