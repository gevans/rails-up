#
# MongoDB cookbook component
#
RailsUp.component do
  name "mongodb"

  version "0.11.0"

  summary "MongoDB is a scalable, high-performance, open source, document-oriented database"

  cookbook "mongodb", :git => "git://github.com/edelight/chef-cookbooks.git", :ref => "0.11.0"

  role "mongodb" do
    run_list "recipe[mongodb::10gen_repo]"
  end
end
