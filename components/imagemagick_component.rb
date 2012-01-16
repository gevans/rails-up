#
# ImageMagick component
#
RailsUp.component do
  name "imagemagick"

  version "1.2.1"

  summary "Installs ImageMagick development and runtime packages (useful with RMagick and MiniMagick)"

  cookbook "imagemagick"

  role "imagemagick" do
    run_list "recipe[imagemagick::devel]"
  end
end
