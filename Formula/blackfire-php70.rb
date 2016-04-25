#encoding: utf-8

require File.expand_path("../../Abstract/abstract-blackfire-php-extension", __FILE__)

class BlackfirePhp70 < AbstractBlackfirePhpExtension
    init
    homepage "https://blackfire.io"
    version '1.10.5'

    url 'http://packages.blackfire.io/homebrew/blackfire-php_1.10.5-darwin_amd64-php70.tar.gz'
    sha256 '5dd8fa4f5ca7e17225bc0fb513a7d549f2cb037d9eae4afc91a43d9911234d88'

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
