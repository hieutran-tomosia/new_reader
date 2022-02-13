require 'open-uri'

class BestsController < ApplicationController
  def index
    @doc = Nokogiri::HTML(URI.open("https://news.ycombinator.com/best"))
    puts Readability::Document.new(@doc.serialize).content
    binding.pry
  end
end
