require'rails_helper'

describe User do

  let(:user) do
    create(:user, email: 'hoge@caraquri.com', password: 'caraquri1111')
  end

  # メールアドレスとパスワードがあれば有効な状態であること
  it "is valid with email and password" do
    expect(user).to be_valid
  end

  describe "メールアドレスのバリデーション" do
    context "正常系" do
      # 正しいEmailアドレスを指定すれば有効であること
      it "is valid with valid email" do
        users = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
        users.each do |email|
          user = build(:user, email: email)
          expect(user).to be_valid
        end
      end
    end

    context "異常系" do
      # メールアドレスの入力が無ければ無効であること
      it "is invalid without a email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      # 重複したメールアドレスは無効であること
      it "is invalid with a duplicate email address" do
        User.create(email: 'duplicate@example.com', password: 'pass1234')
        user = build(:user, email: 'duplicate@example.com')
        user.valid?
        expect(user.errors[:email]).to include("has already been taken")
      end

      # 正しいEmailアドレスを指定しなければ無効であること
      it "is invalid with invalid email" do
        users = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
        users.each do |email|
          user = build(:user, email: email)
          user.valid?
          expect(user.errors[:email]).to include("is invalid")
        end
      end
    end
  end

  describe "パスワードのバリデーション" do
    # パスワードの入力が無ければ無効であること
    it "is invalid without a password" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # パスワードは8桁以上でなければ無効であること
    it "is invalid with password which has 8 or more characters" do
      # 8文字未満
      user = build(:user, password: "a" * 7)
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")

      # 8文字以上
      user = build(:user, password: "b" * 8)
      expect(user).to be_valid
    end
  end
end
