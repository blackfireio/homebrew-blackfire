#encoding: utf-8

require 'formula'

class BlackfireAgent < Formula
    homepage 'https://blackfire.io'
    version '1.18.0'

    if MacOS.prefer_64_bit?
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_1.18.0_amd64.tar.gz'
        sha256 '6f03e9930927fc17bae5caf494594894fcebd3f2f1f0741941bf3325caf2af54'
    else
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_1.18.0_386.tar.gz'
        sha256 'd7d88365824243a01d95dd3d1af0c6961dc1e70f9b508e0c5c58b57a7a186dd3'
    end

    depends_on :arch => :intel

    def install
        bin.install 'usr/bin/blackfire-agent'
        bin.install 'usr/bin/blackfire'
        man1.install 'usr/share/man/man1/blackfire-agent.1.gz'
        sl_etc = etc + 'blackfire'
        sl_etc.mkpath unless sl_etc.exist?
        sl_etc.install 'etc/blackfire/agent.dist'
        sl_etc.install 'etc/blackfire/agent.json.dist'
        FileUtils.cp sl_etc+'agent.dist', sl_etc+'agent' unless File.exists? sl_etc+'agent'
        FileUtils.cp sl_etc+'agent.json.dist', sl_etc+'agent.json' unless File.exists? sl_etc+'agent.json'

        sl_log = var+'log/blackfire'
        sl_log.mkpath unless sl_log.exist?

        sl_run = var + 'run'
        sl_run.mkpath unless sl_run.exist?

        watchdir = var+'lib/blackfire/traces'
        watchdir.mkpath unless watchdir.exist?
    end

    def plist; <<~EOS
        <?xml version="1.0" encoding="UTF-8"?>
        <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
            <plist version="1.0">
                <dict>
                    <key>KeepAlive</key>
                    <true/>
                    <key>Label</key>
                    <string>#{plist_name}</string>
                    <key>ProgramArguments</key>
                    <array>
                        <string>#{bin}/blackfire-agent</string>
                        <string>-config</string>
                        <string>#{etc}/blackfire/agent</string>
                        <string>-log-file</string>
                        <string>#{var}/log/blackfire/agent.log</string>
                    </array>
                    <key>RunAtLoad</key>
                    <true/>
                    <key>WorkingDirectory</key>
                    <string>#{HOMEBREW_PREFIX}</string>
            </dict>
        </plist>
        EOS
    end

    def caveats
        <<~EOS

        \033[32m✩ ✩ ✩ ✩   Register your Agent  ✩ ✩ ✩ ✩\033[0m

        Before launching the agent, you need to register it by running:

        \033[32mblackfire-agent --register\033[0m
        EOS
    end

end
