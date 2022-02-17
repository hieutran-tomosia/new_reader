require 'rails_helper'
require 'nokogiri'

RSpec.describe Bests::BestsService do
  let(:service) do
    Bests::BestsService.new()
  end
  let(:doc) { Nokogiri::HTML5.parse(URI.open("https://news.ycombinator.com/best")) }
  let(:images_test) { 'images/a1.jpeg' }

  describe '#call' do
    it "parse news best url" do
      service.call
      expect(service.parse_news_best.serialize.size).to eq doc.serialize.size
    end

    it "fix errors parse" do
      service.call
      expect(service.best.css('script').first.values[1]).to include 'https://news.ycombinator.com'
    end

    it "add image and content news" do
      service.call
      service.best.css('img').each_with_index do |img, index|
        if index == 1
          expect(img.attributes['src'].value).to eq images_test
        end
      end
    end


  end

end
