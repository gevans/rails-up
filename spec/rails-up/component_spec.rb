describe RailsUp::Component do

  before(:each) do
    @component = RailsUp::Component.new
    @component.name = "My Component"
    @component.version = "1.0.0"
  end

  it "accepts a valid component" do
    @component.valid?.should == true
  end

  it "requires a name" do
    @component.name = nil
    lambda { @component.validate }.should raise_error(RailsUp::ComponentDefinitionError, "Name is required")
  end

  it "requires a version" do
    @component.version = nil
    lambda { @component.validate }.should raise_error(RailsUp::ComponentDefinitionError, "Version is required")
  end

  it "can specify cookbooks" do
    @component.cookbooks = { "my_cookbook" => {} }
    @component.cookbooks.length.should == 1
  end

  describe "roles" do

    before(:each) do
      # @role = Rails::Components::Role.new
    end

  end

end
