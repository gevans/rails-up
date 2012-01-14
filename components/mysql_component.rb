#
# MySQL cookbook component
#
RailsUp.component do
  name "mysql"

  version "1.2.1"

  summary 'Provisions Vagrant boxes with MySQL server and sets the root password to "vagrant"'

  cookbook "mysql", :git => "git://github.com/fnichol/chef-mysql.git", :ref => "all-fixes"

  role "mysql" do
    run_list "recipe[mysql::server]"

    default_attributes \
      :mysql => {
        :server_root_password => "vagrant",
        :allow_remote_root    => true
      }
  end
end
