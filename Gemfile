require "rbconfig"
HOST_OS = RbConfig::CONFIG["host_os"]

source :rubygems

# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"
gem "thor", "~> 0.14.6"
gem "librarian", "~> 0.0.12"
gem "chef", ">= 0.10.8"
gem "vagrant", ">= 0.8.7"
gem "activesupport", ">= 2.3.5"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec", "~> 2.7.0"
  gem "spork", "~> 0.8.5"

  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.6.4"
  gem "rcov", ">= 0"

  gem "guard", "~> 0.8.8"
  gem "guard-bundler", "~> 0.1.3"
  gem "guard-rspec", "~> 0.5.8"
  gem "guard-spork", "~> 0.3.2"

  case HOST_OS
  when /darwin/i
    gem "rb-fsevent"
    gem "growl"
  when /linux/i
    gem "libnotify"
    gem "rb-inotify"
  when /mswin|windows/i
    gem "rb-fchange"
    gem "win32console"
    gem "rb-notifu"
  end
end
