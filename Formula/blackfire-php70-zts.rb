#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp70Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.18.0'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.18.0-darwin_amd64-php70-zts.tar.gz'
    sha256 '4eb0fb90220cc80df9ce9294bde633343586cec5fad0e8918b0f4bd9b9bf1b1f'

    def install
        prefix.install "blackfire.so"
        write_config_file
    end

    def config_file
        super + <<-EOS.undent
        blackfire.agent_socket = unix:///usr/local/var/run/blackfire-agent.sock
        blackfire.agent_timeout = 0.25
        ;blackfire.log_level = 3
        ;blackfire.log_file = /tmp/blackfire.log
        ;blackfire.server_id =
        ;blackfire.server_token =
        EOS
    end
end
