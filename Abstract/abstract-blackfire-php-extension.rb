#encoding: utf-8

require 'formula'

class UnsupportedPhpApiError < RuntimeError
  attr :name

  def initialize (installed_php_version)
    @name = name
    super "Unsupported PHP API Version #{installed_php_version}"
  end
end

class InvalidPhpVersionError < RuntimeError
  attr :name

  def initialize (installed_php_version, required_php_version)
    @name = name
    super <<-EOS.undent
      Version of PHP (#{installed_php_version}) in $PATH does not support this extension
             version (#{required_php_version}). Consider installing blackfire-php-#{installed_php_version} with the `--without-homebrew-php` flag.
    EOS
  end
end

class AbstractBlackfirePhpExtension < Formula
  homepage "https://blackfire.io"
  version '0.24.2'

  url 'http://packages.blackfire.io/homebrew/blackfire-php_0.24.2-darwin_amd64-php53.tar.gz'
  sha1 '6b19e5a6c03a7449df3c16992c3d3b4f20cbc0b6'

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

  def initialize(*)
    super

    if build.without? 'homebrew-php'
      installed_php_version = php_version

      required_php_version = php_branch.sub('.', '').to_s
      unless installed_php_version == required_php_version
        raise InvalidPhpVersionError.new(installed_php_version, required_php_version)
      end
    end
  end

  def self.init
    depends_on :arch => :intel
    depends_on :arch => :x86_64

    option 'without-homebrew-php', "Ignore homebrew PHP and use default instead"
    option 'without-config-file', "Do not install extension config file"
  end

  def php_branch
    matches = /Php5([3-9]+)/.match(self.class.name)
    if matches
      "5." + matches[1]
    else
      raise "Unable to guess PHP branch for #{self.class.name}"
    end
  end

  def php_formula
    'php' + php_branch.sub('.', '')
  end

  def php_version
    i = IO.popen("#{php_binary} -r 'echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;'")
    out = i.readlines.join("")
    i.close

    out
  end

  def php_binary
    if build.without? 'homebrew-php'
      "php"
    else
      "#{(Formula[php_formula]).bin}/php"
    end
  end

  def phpini
    if build.without? 'homebrew-php'
      "php.ini presented by \033[32mphp --ini\033[0m"
    else
      "#{(Formula[php_formula]).config_path}/php.ini"
    end
  end

  def extension
    "blackfire"
  end

  def module_path
    prefix / "#{extension}.so"
  end

  def config_file
    begin
      <<-EOS.undent
      [#{extension}]
      extension="#{module_path}"
      EOS
    rescue Exception
      nil
    end
  end

  def caveats
    caveats = [ "To finish installing #{extension} for PHP #{php_branch}:" ]

    if (build.without? "config-file") || (build.without? "homebrew-php")
      caveats << "  * Add the following lines to #{phpini}:\n"
      caveats << config_file
    else
      caveats << "  * #{config_scandir_path}/#{config_filename} was created,"
      caveats << "    do not forget to remove it upon extension removal."
    end

    caveats << <<-EOS
  * Validate installation via one of the following methods:
  *
  * Using PHP from a webserver:
  * - \033[32mRestart your webserver or PHP-fpm\033[0m.
  * - Write a PHP page that calls "phpinfo();"
  * - Load it in a browser and look for the info on the "#{extension}" module.
  * - If you see it, you have been successful!
  *
  * Using PHP from the command line:
  * - Run \033[32mphp -m | grep blackfire\033[0m
  * - If you see it, you have been successful!
EOS

    caveats.join("\n")
  end

  def config_path
    etc / "php" / php_branch
  end

  def config_scandir_path
    config_path / "conf.d"
  end

  def config_filename
    "ext-" + extension + ".ini"
  end

  def config_filepath
    config_scandir_path / config_filename
  end

  def write_config_file
    if config_filepath.file?
      inreplace config_filepath do |s|
        s.gsub!(/^(zend_)?extension=.+$/, "extension=\"#{module_path}\"")
      end
    elsif config_file
      config_scandir_path.mkpath
      config_filepath.write(config_file)
    end
  end
end

class BlackfirePhp53Extension < AbstractBlackfirePhpExtension
  def self.init opts=[]
    super()
    depends_on "php53" => opts if build.with?('homebrew-php')
  end
end

class BlackfirePhp54Extension < AbstractBlackfirePhpExtension
  def self.init opts=[]
    super()
    depends_on "php54" => opts if build.with?('homebrew-php')
  end
end

class BlackfirePhp55Extension < AbstractBlackfirePhpExtension
  def self.init opts=[]
    super()
    depends_on "php55" => opts if build.with?('homebrew-php')
  end
end

class BlackfirePhp56Extension < AbstractBlackfirePhpExtension
  def self.init opts=[]
    super()
    depends_on "php56" => opts if build.with?('homebrew-php')
  end
end
