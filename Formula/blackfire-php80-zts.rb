#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp80Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.59.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.59.0-darwin_arm64-php80-zts.tar.gz'
        sha256 '12cf4fa8c0f94fcf0eb8914bfac1c8b14ca5fa5b0f47aa69f1239295b3a54dce'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.59.0-darwin_amd64-php80-zts.tar.gz'
        sha256 'd40f3967e710de3dd341b98e22bd1233b3f0dcace1a4223754dbf12e566b523f'
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
