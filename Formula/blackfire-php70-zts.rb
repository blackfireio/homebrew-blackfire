#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp70Zts < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.17.2'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.17.2-darwin_amd64-php70-zts.tar.gz'
    sha256 '4e830c81d5b789258f5dbef4df0143b755467714244e4a7d27eb0af1f8fbcb12'

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
