#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.60.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_arm64-php80.tar.gz'
        sha256 '5654f85a1c1f79599bfd0e5a1e4697534729c8abb05b153dc561199dd657b1d0'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_amd64-php80.tar.gz'
        sha256 '6e2bad3a54bbdd70ea090ef214befe82132f96329f740a7fc644adbd5bed7e8f'
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
