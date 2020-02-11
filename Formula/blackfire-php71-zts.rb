#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp71Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.31.0'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.31.0-darwin_amd64-php71-zts.tar.gz'
    sha256 '8d97147653d2266d4d563b8ff4f2254aa1d5f3be0009b2e358cd4e5933e055d3'

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<~EOS
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
        blackfire.agent_timeout = 0.25
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
