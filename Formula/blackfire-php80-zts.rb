#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.74.1'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.74.1-darwin_arm64-php80-zts.tar.gz'
        sha256 '9f49483c398f1aa36c740aa3a6031acc3787b4f4df52d06e46c90442cb191351'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.74.1-darwin_amd64-php80-zts.tar.gz'
        sha256 '40c8bee26d723fdc8748a617e0f6fd83cc032eaa625c9a98b5e636b41db389a3'
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
