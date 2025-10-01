#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp84 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.45'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.45-darwin_arm64-php84.tar.gz'
        sha256 '48bcdbf39bc1bff8cf30ca98546ca70557fefa3c80cc8e4986886b1cbb236de0'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.45-darwin_amd64-php84.tar.gz'
        sha256 '280a7c2af9459a7b232eb091f68c4cd6dad002a848e8ae5f01e527fc4c2fde4d'
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
