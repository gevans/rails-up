describe RailsUp::Components::Role do

  before(:each) do
    @role = RailsUp::Components::Role.new
    @role.name = "sheen"
    @role.description = "winning!"
  end

  it "accepts a valid role" do
    @role.valid?.should == true
  end

  it "requires a name" do
    @role.name = nil
    lambda { @role.validate }.should raise_error(RailsUp::RoleDefinitionError, "Role name is required")
    @role.valid?.should == false
  end

  it "requires a description" do
    @role.description = nil
    lambda { @role.validate }.should raise_error(RailsUp::RoleDefinitionError, "Role description is required")
    @role.valid?.should == false
  end

  describe RailsUp::Components::RoleBuilder do

    it "creates a valid role" do
      role = RailsUp::Components::RoleBuilder.new do
        name "sheen"
        description "winning!"
      end

      role.build
    end

  end

end
