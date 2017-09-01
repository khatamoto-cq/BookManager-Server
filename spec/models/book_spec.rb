require'rails_helper'
require 'imgur'

describe Book do

  let(:user) do
    create(:user)
  end

  let(:book) do
    create(:book, user: user)
  end

  # 書籍名、価格、購入日があれば有効な状態であること
  it "is valid with name, price, and purchase_date" do
    expect(book).to be_valid
  end

  describe 'validations' do
    describe '#name' do
      it "書籍名は必須であること"do
        is_expected.to validate_presence_of(:name)
      end
    end

    describe '#price' do
      it "価格は必須であること" do
        is_expected.to validate_presence_of(:price)
      end

      it '価格は数値でなければ無効であること' do
        is_expected.to validate_numericality_of(:price)
      end
    end

    describe '#purchase_date' do
      context "正常系" do
        it "購入日は正しい日付形式であれば有効であること" do
          book = build(:book, purchase_date: "2017-1-1 1:1:1", user: user)
          expect(book).to be_valid

          book = build(:book, purchase_date: "2017-12-31 23:59:59", user: user)
          expect(book).to be_valid
        end
      end

      context "異常系" do
        it "購入日は日付形式でなければ無効であること" do
          book = build(:book, purchase_date: "2017-13-1 25:60:60")
          book.valid?
          expect(book.errors[:purchase_date]).to include("is not a date")
        end
      end
    end
  end

  describe "メール画像の登録" do
    it "base64にエンコードした文字列をImgurにアップロードして返却されたURLでimage_urlを保存すること" do
      book = build(:book, user: user)
      book.image_data = 'dummy base64'
      allow(Imgur).to receive(:post).and_return('http://i.imgur.com/ttKTi1V.jpg')
      book.save
      book.reload
      expect(book.image_url).to eq 'http://i.imgur.com/ttKTi1V.jpg'
    end
  end
end
