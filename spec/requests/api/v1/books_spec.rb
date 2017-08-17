require 'rails_helper'

describe 'Books API', type: :request do

  before :each do
    book1 = create(:book)
    book2 = create(:book, name: '初めてのPython')
    book3 = create(:book, name: 'Kotlinスタートブック')
    book4 = create(:book, name: 'Effective Android')
    book5 = create(:book, name: 'ドメイン駆動設計')
    @books = [book1, book2, book3, book4, book5]
  end

  describe "GET /api/v1/books" do
    it "populate all books to @books" do
      get api_v1_books_path, headers: {'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json'}
      #expect(assigns(:books)).to match_array(@books)
      expect(response).to be_success
      puts JSON.parse(response.body)
    end
  end
end
