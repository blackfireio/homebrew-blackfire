#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.83.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.83.0-darwin_arm64-php74-zts.tar.gz'
        sha256 '7bcfcb8bbcb2d0e150243e808e9e381b8fdd1e3f1803d0d2ae85268fbc1f59bb'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.83.0-darwin_amd64-php74-zts.tar.gz'
        sha256 'd46c01a2bd19cc5434d07d9a72858f6fa927b7c4a280ac05ea1b3204d9d66ba2'
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
