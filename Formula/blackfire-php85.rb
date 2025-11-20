#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp85 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.51'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.51-darwin_arm64-php85.tar.gz'
        sha256 'eca6f8896a28f9fffe09cec34a3cafd6b4bac073887d5a61fa4ad216a4712935'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.51-darwin_amd64-php85.tar.gz'
        sha256 '38ae9a2f5849dfd31b6b57738281f939b471a31f53041c1e6ab6cc2c5d3bbd9c'
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
