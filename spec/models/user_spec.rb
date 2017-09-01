require'rails_helper'

describe User, type: :model  do
  describe 'validations' do
    subject { User.new(email: 'hoge@caraquri.com', password: 'caraquri1234') }

    describe '#email' do
        context "正常系" do
        it "メールアドレスは必須であること" do
          is_expected.to validate_presence_of(:email)
        end

        it "正しいEmailアドレスを指定すれば有効であること" do
          users = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn)
          users.each do |email|
            user = build(:user, email: email)
            expect(user).to be_valid
          end
        end
      end

      context "異常系" do
        it "重複したメールアドレスは無効であること" do
          is_expected.to validate_uniqueness_of(:email)
        end

        it "正しいEmailアドレスを指定しなければ無効であること" do
          users = %w(user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com)
          users.each do |email|
            user = build(:user, email: email)
            user.valid?
            expect(user.errors[:email]).to include("is invalid")
          end
        end
      end
    end

    describe "#password" do
      it "パスワードは必須であること" do
        is_expected.to have_secure_password
      end

      it "パスワードは8桁以上でなければ無効であること" do
        is_expected.to validate_length_of(:password).is_at_least(8)
      end
    end
  end
end
