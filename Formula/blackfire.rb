#encoding: utf-8

require 'formula'

class Blackfire < Formula
    homepage 'https://blackfire.io'
    version '2.29.5'

    if Hardware::CPU.arm?
        url 'https://packages.blackfire.io/blackfire/2.29.5/blackfire-darwin_arm64.pkg.tar.gz'
        sha256 'd5053076b1c70527fa80c06cd3b3478b1dd3804233a64991c22ee9a91432d83e'
    else
        url 'https://packages.blackfire.io/blackfire/2.29.5/blackfire-darwin_amd64.pkg.tar.gz'
        sha256 'f3f51e9d74d781c2977e11a958ccecaf145e1b39df6a8daa995cc2ac300c08f6'
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
