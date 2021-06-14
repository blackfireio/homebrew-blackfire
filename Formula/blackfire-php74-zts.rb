#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp74Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.60.0'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_arm64-php74-zts.tar.gz'
        sha256 '968d97102e946b80e0146eac5d90b7f4c268ab8d98fca6cc3732b2da528defe8'
    else
        url 'https://packages.blackfire.io/homebrew/blackfire-php_1.60.0-darwin_amd64-php74-zts.tar.gz'
        sha256 'a1901d58a767f57f2cfd7fc62b28594513b57fd1dfac7d50f2e200d9a2f181a5'
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
