require 'spec_helper'

describe DZT do
  before :each do
    @binary = File.expand_path(File.join(__FILE__, '../../../bin/dzt'))
    @fixtures_dir = File.expand_path(File.join(__FILE__, '../../fixtures'))
  end
  describe "#help" do
    it "displays help" do
      help = `"#{@binary}" help`
      help.should include "dzt - Tile images into deep-zoom tiles"
    end
  end
  describe "#slice" do
    it "slices an image" do
      goya = File.join(@fixtures_dir, "francisco-jose-de-goya-y-lucientes-senora-sabasa-garcia.jpg")
      Dir.mktmpdir do |tmpdir|
        `"#{@binary}" slice "#{goya}" --output #{tmpdir}`
        Dir["#{tmpdir}/*"].map { |dir| dir.split("/").last.to_i }.sort.should == (0..12).to_a
        # center
        image = Magick::Image::read("#{tmpdir}/11/1_1.jpg").first
        image.columns.should == 512
        image.rows.should == 512
      end
    end
  end
end
