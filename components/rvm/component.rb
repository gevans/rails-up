#
# RVM cookbook component
#
RailsUp.component do
  name "rvm"

  version "0.8.6"

  summary "Provisions Vagrant boxes with RVM for managing Rubies system-wide and per-user"

  description <<-DESC.strip_heredoc
    Ruby Version Manager is a command-line tool which allows you to easily
    install, manage, and work with multiple ruby environments from
    interpreters to sets of gems.
  DESC

  roles "rvm"
end
