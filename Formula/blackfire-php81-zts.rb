#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp81Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.81.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.81.0-darwin_arm64-php81-zts.tar.gz'
        sha256 '8e330d182ce65c24d61bf141151224db0ae57ea52bc98d17e7b38012167d1644'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.81.0-darwin_amd64-php81-zts.tar.gz'
        sha256 '206731a2af7da684251c7d89510989ecf070bb486a48ee4b8ab105a1a914b7cf'
    end

    def install
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
