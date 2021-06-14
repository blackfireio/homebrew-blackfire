#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.60.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_arm64-php80-zts.tar.gz'
        sha256 'cc3460e442325081be85c26106158feab1e739d6ad08c2705dabf075823bc256'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_amd64-php80-zts.tar.gz'
        sha256 '2d1b77ef76788200029fb27959d3954a2b611e400771c3399b5420e176115db1'
    end

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
