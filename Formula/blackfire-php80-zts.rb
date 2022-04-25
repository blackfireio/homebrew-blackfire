#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.77.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.77.0-darwin_arm64-php80-zts.tar.gz'
        sha256 '0eab343fc5fb49c0c908f60abaa96e9a72f3e2407b7043a755b0c0090d36b24a'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.77.0-darwin_amd64-php80-zts.tar.gz'
        sha256 'ceeed081a29b04d4246f2edb2eff8d28b4886bbf545cc38d11fd7bd443beb8d1'
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
