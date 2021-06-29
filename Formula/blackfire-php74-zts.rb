#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.63.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.63.0-darwin_arm64-php74-zts.tar.gz'
        sha256 'b55cf28bdcdc01b76b8f5db84ffaae1b0407e5be26253ab67f0bdc7bc5d5edc6'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.63.0-darwin_amd64-php74-zts.tar.gz'
        sha256 'd93488996a56f58f9ba4c5fb5772e63cb10d6e50382d67c91d0df08a384a3a9f'
    end

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<~EOS
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
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
