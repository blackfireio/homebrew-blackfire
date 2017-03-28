#encoding: utf-8

require 'formula'

class BlackfireAgent < Formula
    homepage 'https://blackfire.io'
    version '1.11.0'

    if MacOS.prefer_64_bit?
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_1.11.0_amd64.tar.gz'
        sha256 '2f2059cb96bc6931827787d26626c57f64ff37850ec0897d745a872ac0621130'
    else
        url 'http://packages.blackfire.io/homebrew/blackfire-agent_1.11.0_386.tar.gz'
        sha256 '3453971d4069167a12ef217d04994dfaa996576d49426b48a7af133e696bac9a'
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
        EOS
    end

end
