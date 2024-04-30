#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp83 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.14'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.14-darwin_arm64-php83.tar.gz'
        sha256 '64f92aa2b9fa4ac357817e37c62bdcc00d583c3da2ec00510aec0db4fe712f0e'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.14-darwin_amd64-php83.tar.gz'
        sha256 '9e9e6abb10f28fb20fd64e687fa8751f965c6b32aa3351f97c78e9f670c1b0a2'
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
