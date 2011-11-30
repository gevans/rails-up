name "rvm"

  description "Provisions Vagrant boxes with RVM for managing Rubies system-wide and per-user."

  run_list "recipe[rvm::system]", "recipe[rvm::vagrant]"

  default_attributes :rvm => {
    :upgrade      => "head",
    :default_ruby => "1.9.2",
    :rubies       => ["1.9.2"],
    :rvmrc        => {
      :rvm_project_rvmrc             => 1,
      :rvm_gemset_create_on_use_flag => 1,
      :rvm_trust_rvmrcs_flag         => 1
    },
    :global_gems  => [
      { :name => "bundler" }
    ],
    :group_users  => ["vagrant"],
  }
