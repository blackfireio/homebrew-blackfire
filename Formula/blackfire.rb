#encoding: utf-8

require 'formula'

class Blackfire < Formula
    homepage 'https://blackfire.io'
    version '2.28.7'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/blackfire/2.28.7/blackfire-darwin_arm64.pkg.tar.gz'
        sha256 '83b7ec1bab16751997bcbd52f6f237c8d1c329258e7732eba7b61da70d6336cb'
    else
        url 'https://packages.blackfire.io/blackfire/2.28.7/blackfire-darwin_amd64.pkg.tar.gz'
        sha256 '1eddcadbdecc1318252a6b70b3f46f8501c53e17f56d3908a0d46f4ffc89f823'
    end

    conflicts_with "blackfire-agent", because: "blackfire replaces the blackfire-agent package"

    def install
        bin.install 'usr/bin/blackfire'
        man1.install 'usr/share/man/man1/blackfire.1.gz'
        sl_etc = etc + 'blackfire'
        sl_etc.mkpath unless sl_etc.exist?
        sl_etc.install 'etc/blackfire/agent.dist'
        FileUtils.cp sl_etc+'agent.dist', sl_etc+'agent' unless File.exist? sl_etc+'agent'

        sl_log = var+'log/blackfire'
        sl_log.mkpath unless sl_log.exist?

        sl_run = var + 'run'
        sl_run.mkpath unless sl_run.exist?

        watchdir = var+'lib/blackfire/traces'
        watchdir.mkpath unless watchdir.exist?

        inreplace "macos_blackfire.plist" do |s|
            s.gsub!("\#{plist_name}", "#{plist_name}")
            s.gsub!("\#{bin}", "#{bin}")
            s.gsub!("\#{etc}", "#{etc}")
            s.gsub!("\#{var}", "#{var}")
            s.gsub!("\#{HOMEBREW_PREFIX}", "#{HOMEBREW_PREFIX}")
        end
        prefix.install Dir["*"]
        prefix.install_symlink "macos_blackfire.plist" => "#{plist_name}.plist"
    end

    service do
        name macos: "#{plist_name}"
    end

    def caveats
        <<~EOS

        \033[32m✩ ✩ ✩ ✩   Register your Agent  ✩ ✩ ✩ ✩\033[0m

        Before launching the agent, you need to register it by running:

        \033[32mblackfire agent:config\033[0m
        EOS
    end

end
