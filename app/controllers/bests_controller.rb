require 'open-uri'

class BestsController < ApplicationController
  def index
    service = Bests::BestsService.new()
    service.call
    @doc = service.best
  end

  def get_content
    meta = Nokogiri::HTML5.parse(URI.open(params[:link])).css('meta')
    content = ''
    meta.each do |m|
      if m.attributes['name'].present? && m.attributes['name'].value == 'description'
        content = m.attributes['content'].value
      end
    end

    render json: {content: content}
  end
end
