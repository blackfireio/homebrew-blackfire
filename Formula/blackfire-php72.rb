#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp72 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.22'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_arm64-php72.tar.gz'
        sha256 'db460b6aa99cd0fe1018acaa709e32b8eb384970c63fb6ddbc122c9733639309'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_amd64-php72.tar.gz'
        sha256 '32f384ab57217591adea6ace77a8d826527c985dacf44c0bffdec5be47a2dca0'
    end

    def install
        check_php_version
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        if Hardware::CPU.arm?
            agent_socket = 'unix:///opt/homebrew/var/run/blackfire-agent.sock'
        else
            agent_socket = 'unix:///usr/local/var/run/blackfire-agent.sock'
        end

        super + <<~EOS
        blackfire.agent_socket = #{agent_socket}

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

        ;Enables Blackfire Monitoring
        ;Enabled by default since version 1.61.0
        ;blackfire.apm_enabled = 1
        EOS
    end
end
