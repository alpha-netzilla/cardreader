require "spec_helper"

RSpec.describe "Cardreader" do
  it "has a version number" do
    expect(Cardreader::VERSION).not_to be nil
  end
end

RSpec.describe "Parse JSON" do
  let(:manage) {
    Cardreader::Manage.new (
		  key = "******"
	  ) 
  }

  it "should have person" do
    result = JSON.parse(manage.detect("example/card.jpg"))
		expect(result["person"]).to eq "Shinya Funaki"
  end
end
