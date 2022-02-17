class Bests::BestsService
  attr_accessor :best
  BEST_URL = "https://news.ycombinator.com/best"

  def call
    parse_news_best
    fix_errors_parse
    add_image_and_content_news
  end

  def parse_news_best
    @best = Nokogiri::HTML5.parse(URI.open(BEST_URL))
  end

  def fix_errors_parse
    @best.css('img').each do |img|
      img.attributes['src'].value = 'https://news.ycombinator.com/' + img.attributes['src'].value
    end
    @best.css('link').each do |link|
      link.attributes['href'].value = '' if link.attributes['href'].value.include? 'news.css'
    end
    @best.css('script').each{|script| script.attributes['src'].value = 'https://news.ycombinator.com/' + script.attributes['src'].value}
  end

  def add_image_and_content_news
    count_img = 0
    count_a   = 0
    @best.css('table').each do |table|
      if table.attributes['class'].present? && table.attributes['class'].value == 'itemlist'
        # remove more link
        table.css('tbody tr').last.remove

        table.css('tbody tr').each do |tr|
          if tr.attributes['class'].present? && tr.attributes['class'].value == 'athing'
            tr.css('td').each_with_index do |td, index|
              if index == 2
                count_img += 1
                @link = td.css('a').first.attributes['href'].value
                @link = 'https://news.ycombinator.com/' + @link if @link.include? 'item?id'
                td << "<a href='#{@link}'><img class='img-best' src='images/a#{count_img}.jpeg'></a>"
              end
            end
          end

          if tr.attributes['class'].blank?
            tr.css('td').each_with_index do |td, index|
              if index == 1
                count_a += 1
                html =
                  <<-HTML
                    <a onclick="Bests.getContent('#{@link}', #{count_a})"> | get content</a>
                    <br>
                    <p id="news_content_#{count_a}" class="content-item"></p>
                  HTML
                td << html
              end
            end
          end
        end
      end
    end
  end
end

