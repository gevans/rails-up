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

    default_attributes \
      :redis => {
        :source => {
          :version      => "2.4.5",
          :tar_checksum => "babeb1a1d05281b5e00ca0a519cfc3f9"
        }
      }
  end
end
