#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.82.1'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.82.1-darwin_arm64-php74-zts.tar.gz'
        sha256 '190248a15ed7d234965db3b81d3ff37922375f3fd495a8b6ae022cf9613e55d5'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.82.1-darwin_amd64-php74-zts.tar.gz'
        sha256 '8f9b4c310ee0d78e977fe4b27c6f8b04ccb5691dbe5e346bb04897496504e67a'
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
