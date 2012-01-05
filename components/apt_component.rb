#
# apt cookbook component
#
RailsUp.component do
  name "apt"

  version "1.2.0"

  summary "Apt cookbook with support for using apt cacher with chef-solo"

  cookbook "apt", :git => "git://github.com/fnichol/chef-apt.git", :ref => "cacher-client-solo-support"
end
