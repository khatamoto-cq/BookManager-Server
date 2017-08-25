require 'rails_helper'

describe 'Books API', type: :request do

  before :each do
    create(:book)
    create(:book, name: '初めてのPython')
    create(:book, name: 'Kotlinスタートブック')
    create(:book, name: 'Effective Android')
    create(:book, name: 'ドメイン駆動設計')
  end

  let(:user) do
    create(:user)
  end

  def authenticated_header
    token = Knock::AuthToken.new(payload: { sub: user.id }).token
    {
      'Authorization': "Bearer #{token}"
    }
  end

  describe "GET /api/v1/books" do
    it "populate all books to @books" do
      get api_v1_books_path, headers: authenticated_header
      expect(response).to be_success

      json = JSON.parse(response.body).to_json
      expect(json).to be_json
      expect(json).to be_json_including([
        id: Integer,
        image_url: nil,
        name: /w+/,
        price: Integer,
        purchase_date: /^\d{4}-\d{2}-\d{2}.+/
      ])
    end
  end

  describe "POST /api/v1/books" do
    it "registers a book" do
      post_attributes = {
        book: {
          name: "Amazon Web Services設計パターン",
          price: 3980
        }
      }
      expect{
        post "/api/v1/books", params: post_attributes, headers: authenticated_header
      }.to change(Book, :count).by(1)
    end
  end

  describe "PATCH /api/v1/books/1" do
    it "updates a book" do
      book = create(:book)
      new_attributes = {
        book: {
          name: '詳解Swift第4版',
          price: 5100,
          purchase_date: '2017-12-24 12:01:01'
        }
      }
      patch "/api/v1/books/#{book.id}", params: new_attributes, headers: authenticated_header
      expect(response).to be_success

      json = JSON.parse(response.body)
      expect(json['name']).to eq('詳解Swift第4版')
      expect(json['price']).to eq(5100)
      expect(json['purchase_date']).to eq('2017-12-24T12:01:01.000Z')
    end
  end
end
