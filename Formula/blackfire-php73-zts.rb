#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp73Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.31.0'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.31.0-darwin_amd64-php73-zts.tar.gz'
    sha256 'fbb1b9c2558b52346456b17cfcad84689e6cc7bd58063e9648133dcc44f51c10'

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
