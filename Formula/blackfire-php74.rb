#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.60.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_arm64-php74.tar.gz'
        sha256 '450a9eb2fad9fe9efc5996ad73d3da30778b3fecf760a9338e685aa4ae560c8f'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_amd64-php74.tar.gz'
        sha256 '1a24c799bd2f086bd68bcda9783cc922adcac6ff53e4a3876c1b033931e8d763'
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
