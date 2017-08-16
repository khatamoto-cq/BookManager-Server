require'rails_helper'

describe Book do

  let(:book) do
    create(:book)
  end

  # 書籍名、価格、購入日があれば有効な状態であること
  it "is valid with name, price, and purchase_date" do
    expect(book).to be_valid
  end

  describe "書籍名のバリデーション" do
    it "is invalid without a name" do
      book = build(:book, name: nil)
      book.valid?
      expect(book.errors[:name]).to include("can't be blank")
    end
  end

  describe "価格のバリデーション" do
    # 価格の入力が無ければ無効であること
    it "is invalid without a price" do
      book = build(:book, price: nil)
      book.valid?
      expect(book.errors[:price]).to include("can't be blank")
    end

    # 価格は数値でなければ無効であること
    it "is invalid with non number" do
      book = build(:book, price: "abc")
      book.valid?
      expect(book.errors[:price]).to include("is not a number")
    end
  end

  describe "日付のバリデーション" do
    context "正常系" do
      # 購入日は正しい日付形式であれば有効であること
      it "is invalid without valid date" do
        book = build(:book, purchase_date: "2017-1-1 1:1:1")
        expect(book).to be_valid

        book = build(:book, purchase_date: "2017-12-31 23:59:59")
        expect(book).to be_valid
      end
    end

    context "異常系" do
      # 購入日は日付形式でなければ無効であること
      it "is invalid without valid date" do
        book = build(:book, purchase_date: "2017-13-1 25:60:60")
        book.valid?
        expect(book.errors[:purchase_date]).to include("is not a date")
      end
    end
  end
end
