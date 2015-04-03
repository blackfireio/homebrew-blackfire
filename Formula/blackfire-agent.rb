#encoding: utf-8

require 'formula'

class BlackfireAgent < Formula
    homepage 'https://blackfire.io'
    version '0.23.1'

    if MacOS.prefer_64_bit?
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_0.23.1_amd64.tar.gz'
        sha1 '72a79612131f9dedcb0e10b5f16c11600c57c444'
    else
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_0.23.1_386.tar.gz'
        sha1 '4564a62600ad8ef0ee79492d9772a3611fe7fb00'
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

    def plist; <<-EOS.undent
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
        <<-EOS.undent

        \033[32m✩ ✩ ✩ ✩   Register your Agent  ✩ ✩ ✩ ✩\033[0m

        Before launching the agent, you need to register it by running:

        \033[32mblackfire-agent --register\033[0m

        If this is an upgrade and you are using launchd, \033[32mdo not forget to reload the Agent service\033[0m

        launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.blackfire-agent.plist
        launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.blackfire-agent.plist

        If this is an install:
        EOS
    end

end
