#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp81Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.78.1'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.78.1-darwin_arm64-php81-zts.tar.gz'
        sha256 'f4e326f6b12cd28f9d6b1859752a6ce0d59025e80b534f7377748b7251833a7b'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.78.1-darwin_amd64-php81-zts.tar.gz'
        sha256 '9b482b6785e5e929b964fbe64ba99c246710380d8408f24abf399c72a3e5c811'
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
