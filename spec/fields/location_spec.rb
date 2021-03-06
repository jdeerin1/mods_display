require "spec_helper"

def mods_display_location(mods_record)
  ModsDisplay::Location.new(mods_record, ModsDisplay::Configuration::Base.new, mock("controller"))
end

describe ModsDisplay::Note do
  before(:all) do
    @location = Stanford::Mods::Record.new.from_str("<mods><location><physicalLocation>The Location</physicalLocation></location></mods>", false).location
    @display_label = Stanford::Mods::Record.new.from_str("<mods><location displayLabel='Special Label'><shelfLocation>On Shelf A</shelfLocation></location></mods>", false).location
    @repository_label = Stanford::Mods::Record.new.from_str("<mods><location type='repository'><physicalLocation>Location Field</physicalLocation></location></mods>", false).location
  end
  describe "label" do
    it "should have a default label" do
      mods_display_location(@location).fields.first.label.should == "Location"
    end
    it "should use the displayLabel attribute when one is available" do
      mods_display_location(@display_label).fields.first.label.should == "Special Label"
    end
    it "should use get a label from a list of translations" do
      mods_display_location(@repository_label).fields.first.label.should == "Repository"
    end
  end  
  
end