#
# ImageMagick component
#
RailsUp.component do
  name "imagemagick"

  version "0.2.2"

  summary "Installs ImageMagick development and runtime packages (useful with RMagick and MiniMagick)"

  cookbook "imagemagick", "0.2.2"

  role "imagemagick" do
    run_list "recipe[imagemagick::devel]"
  end
end
