#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp81 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.82.1'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.82.1-darwin_arm64-php81.tar.gz'
        sha256 '28384ec6b95cd6fb433af2c7b833d8c620c308363280353b4b5008c037976bf8'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.82.1-darwin_amd64-php81.tar.gz'
        sha256 'c6b70fb3c941c64fb4a8ce8c1659d88430a697a60c608a111da03b9d61936606'
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
