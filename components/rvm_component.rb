#
# RVM cookbook component
#
RailsUp.component do
  name "rvm"

  version "0.8.6"

  summary "Provisions Vagrant boxes with RVM for managing Rubies system-wide and per-user"

  cookbook "rvm", :git => "git://github.com/fnichol/chef-rvm", :ref => "v0.8.6"

  role "rvm" do
    run_list "recipe[rvm::system]", "recipe[rvm::vagrant]"

    default_attributes \
      :rvm => {
        :upgrade      => "latest",
        :default_ruby => "1.9.3",
        :rubies       => ["1.9.3"],
        :rvmrc        => {
          :rvm_project_rvmrc             => 1,
          :rvm_gemset_create_on_use_flag => 1,
          :rvm_trust_rvmrcs_flag         => 1
        }
      }
  end
end
