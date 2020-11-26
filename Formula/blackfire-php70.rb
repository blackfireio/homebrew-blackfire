#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp70 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.46.4'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.46.4-darwin_amd64-php70.tar.gz'
    sha256 '93e2e0352387964b463f5d766bbe1490ac5ebbcd03d61f0b9165c4c98b006134'

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
        EOS
    end
end
