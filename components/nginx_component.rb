#
# Nginx cookbook component
#
RailsUp.component do
  name "nginx"

  version "0.99.2"

  summary "Builds and installs Nginx, a web and reverse proxy server, from source"

  cookbook "nginx", "0.99.2"

  forward_port "nginx", 80 => 8080

  role "nginx" do
    run_list "recipe[nginx::source]"

    default_attributes \
      :nginx => {
        :version => "1.1.12"
      }
  end
end
