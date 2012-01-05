describe RailsUp do

  # before(:each) do
  #   @component = RailsUp.component do
  #     name        "my component"
  #     version     "1.0.0"
  #     summary     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #     description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #   end
  # end

  # it "should return a component" do
  #   component = RailsUp.component do
  #     name        "my component"
  #     version     "1.0.0"
  #     summary     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #     description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #   end

  #   @component.class.name.should == "RailsUp::Component"
  # end

  # it "requires a name" do
  #   invalid_component = RailsUp::ComponentBuilder.new do
  #     version "1.0.0"
  #   end

  #   lambda { invalid_component.build }.should raise_error(RailsUp::ComponentDefinitionError, "Name is required")
  # end

  # it "requires a version" do
  #   invalid_component = RailsUp::ComponentBuilder.new do
  #     version "1.0.0"
  #   end

  #   lambda { invalid_component.build }.should raise_error(RailsUp::ComponentDefinitionError, "Version is required")
  # end

  # it "should have a version" do
  #   @component.version.should_not be_empty
  # end

  # it "should have a summary" do
  #   @component.summary.should_not be_empty
  # end

  # it "should have a description" do
  #   @component.description.should_not be_empty
  # end

  # describe "cookbooks" do

  #   before(:each) do
  #     @component = RailsUp.component do
  #       name        "my component"
  #       version     "1.0.0"
  #       summary     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #       description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In a arcu ipsum, et facilisis tellus. Donec viverra tempus eros at blandit."
  #       cookbook    "my-cookbook", :git => "git://github.com/someone/my-cookbook.git", :ref => "1.0.0"
  #     end
  #   end

  #   # it "should"

  # end

end
