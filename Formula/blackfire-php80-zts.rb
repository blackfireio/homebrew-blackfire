#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.56.0'

    url 'https://packages.blackfire.io/homebrew/blackfire-php_1.56.0-darwin_amd64-php80-zts.tar.gz'
    sha256 'ef0969310c40c40ef0395fd01d334c63414f44675e86177c47eaa7828f7cc7a0'

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
