require'rails_helper'

describe User do

  let(:user) do
    create(:user, email: 'hoge@caraquri.com', password: 'caraquri1111')
  end

  # メールアドレスとパスワードがあれば有効な状態であること
  it "is valid with email and password" do
    expect(user).to be_valid
  end

  # メールアドレスの入力が無ければ無効であること
  it "is invalid without a email" do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # パスワードの入力が無ければ無効であること
  it "is invalid without a password" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    User.create(email: 'duplicate@example.com', password: 'pass1234')
    user = build(:user, email: 'duplicate@example.com')
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
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
