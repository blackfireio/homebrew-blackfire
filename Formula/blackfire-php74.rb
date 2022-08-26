#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.81.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.81.0-darwin_arm64-php74.tar.gz'
        sha256 '43522f5d5cf1a7c78ddbcb837196a525776d2a14d52dede01ba03f0d680f61d3'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.81.0-darwin_amd64-php74.tar.gz'
        sha256 '727fe207aec3f325e148a5e345eca4ae17635cf3c8c911e4c00d944cc4cd62c3'
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
