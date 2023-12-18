#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp83 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.4'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.4-darwin_arm64-php83.tar.gz'
        sha256 '1f3262152724b65b75f0d965b35f2a0875a8a7e47948fa56c77fae1f20c918cc'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.4-darwin_amd64-php83.tar.gz'
        sha256 '37ad8a7a3fe0b74bcfd19e3bcd04acb52d8ec46b9d909e173edb6131ff48317e'
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
