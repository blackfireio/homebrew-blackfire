#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp71 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.50.0'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.50.0-darwin_amd64-php71.tar.gz'
    sha256 'a3ae1ef3d8e4ebff10d293e8f3d7dea55d746c933f9e41593e027dcbd7c6f1db'

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
