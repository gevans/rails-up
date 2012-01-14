describe RailsUp::ComponentBuilder do

  before(:each) do
    @builder = RailsUp::ComponentBuilder.new do
      name "Useless Component"
      version "0.1.0"
      summary "I do nothing!"
    end
  end

  it "builds a component" do
    component = @builder.build
    component.class.name.should == "RailsUp::Component"
  end

end
