#encoding: utf-8

require 'formula'

class Blackfire < Formula
    homepage 'https://blackfire.io'
    version '2.5.2'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/blackfire/2.5.2/blackfire-darwin_arm64.pkg.tar.gz'
        sha256 '88be6a9f84531f0768c63fac2aa855fbafc31ddf18b4b871c08fd3d2482d84a7'
    else
        url 'https://packages.blackfire.io/blackfire/2.5.2/blackfire-darwin_amd64.pkg.tar.gz'
        sha256 'ed69f2279e12a16df626b8c8531e1a4dd8c69f259b2c55d02676cae289bb630a'
    end

    conflicts_with "blackfire-agent", because: "blackfire replaces the blackfire-agent package"

    def install
        bin.install 'usr/bin/blackfire'
        man1.install 'usr/share/man/man1/blackfire.1.gz'
        sl_etc = etc + 'blackfire'
        sl_etc.mkpath unless sl_etc.exist?
        sl_etc.install 'etc/blackfire/agent.dist'
        FileUtils.cp sl_etc+'agent.dist', sl_etc+'agent' unless File.exists? sl_etc+'agent'

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
                        <string>#{bin}/blackfire</string>
                        <string>agent:start</string>
                        <string>--config</string>
                        <string>#{etc}/blackfire/agent</string>
                        <string>--log-file</string>
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

        \033[32mblackfire agent:config\033[0m
        EOS
    end

end
