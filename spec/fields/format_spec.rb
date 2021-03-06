require "spec_helper"

def mods_display_format(mods)
  ModsDisplay::Format.new(mods, ModsDisplay::Configuration::Base.new, mock("controller"))
end

describe ModsDisplay::Format do
  before(:all) do
    @format = Stanford::Mods::Record.new.from_str("<mods><typeOfResource>Format</typeOfResource></mods>", false).typeOfResource
    @display_label = Stanford::Mods::Record.new.from_str("<mods><typeOfResource displayLabel='SpecialFormat'>Mixed Materials</typeOfResource></mods>", false).typeOfResource
    @space_format = Stanford::Mods::Record.new.from_str("<mods><typeOfResource>Mixed Materials</typeOfResource></mods>", false).typeOfResource
    @slash_format = Stanford::Mods::Record.new.from_str("<mods><typeOfResource>Manuscript/Archive</typeOfResource></mods>", false).typeOfResource
  end
  
  describe "labels" do
    it "should return the format label" do
      mods_display_format(@format).to_html.should match(/<dt title='Format'>Format:<\/dt>/)
    end
    it "should return the displayLabel when available" do
      mods_display_format(@display_label).to_html.should match(/<dt title='SpecialFormat'>SpecialFormat:<\/dt>/)
    end
  end
  describe "format_class" do
    it "should wrap the format in a span w/ the format class in it" do
      mods_display_format(@format).to_html.should match(/<span class='format'>Format<\/span>/)
    end
    it "should remove any spaces" do
      ModsDisplay::Format.send(:format_class, "Mixed Materials").should == "mixed_materials"
    end
    it "should replace any slashes" do
      ModsDisplay::Format.send(:format_class, "Manuscript/Archive").should == "manuscript_archive"
    end
  end

end