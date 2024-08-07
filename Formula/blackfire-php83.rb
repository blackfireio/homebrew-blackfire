#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp83 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.22'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_arm64-php83.tar.gz'
        sha256 'd322381ef5ad81d80a184261f0876f72bcecdf3a47712a4ec3309f7d41f690b9'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_amd64-php83.tar.gz'
        sha256 'a8f9ab69509182b0be4d7ced8fee5c6a498c4ddf0b2bdec07633395f2ce065e6'
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
