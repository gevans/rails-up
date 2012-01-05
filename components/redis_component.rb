#
# Redis cookbook component
#
RailsUp.component do
  name "redis"

  version "0.0.3"

  summary "Builds and installs Redis server from source package"

  cookbook "redis", :git => "git://github.com/fnichol/chef-redis.git", :ref => "source-install"

  role "redis" do
    run_list "recipe[redis::source]"
  end
end
