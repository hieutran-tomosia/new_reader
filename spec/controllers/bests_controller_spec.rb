require 'rails_helper'


RSpec.describe BestsController, type: :controller do
  let(:service) do
    Bests::BestsService.new()
  end

  let(:params) { {link: 'https://dkb.io/post/google-search-is-dying'} }


  describe "GET /index" do

    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns @doc" do
      service.call

      get :index
      expect(assigns[:doc].serialize.size).to eq(service.best.serialize.size)
    end
  end

  describe "GET get_content" do

    it 'returns http success' do
      get :get_content, params: params
      expect(response).to have_http_status(:success)
    end

    it "ajax get content" do
      get :get_content, params: params

      meta = Nokogiri::HTML5.parse(URI.open(params[:link])).css('meta')
      meta.each do |m|
        if m.attributes['name'].present? && m.attributes['name'].value == 'description'
          expect(response.body).to include m.attributes['content'].value
        end
      end
    end
  end
end
