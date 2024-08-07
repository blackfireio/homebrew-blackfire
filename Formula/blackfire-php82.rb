#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp82 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.92.22'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_arm64-php82.tar.gz'
        sha256 '20462bc13a6085b297bb68247cb19958919512403f67e97324adc5c8abad06d7'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.92.22-darwin_amd64-php82.tar.gz'
        sha256 'ae6f1c0fb1d461691a5efca9f0fd90f200d24124d29065544ca59601950cc014'
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
