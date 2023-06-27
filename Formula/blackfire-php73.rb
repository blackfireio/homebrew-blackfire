#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp73 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.88.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.88.0-darwin_arm64-php73.tar.gz'
        sha256 'b74dbf3d75592b52c18d798c0fac07cdd7b0d29d3a4900d3ea50022f1ad049ca'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.88.0-darwin_amd64-php73.tar.gz'
        sha256 '6029bcc87e9eab04bd7150a9278fb7720e28746a44aa8f6fb8a4308ad996de12'
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
