require 'spec_helper'

# No1
RSpec.describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }
    context '12歳以下の場合' do
      let(:age) { 12 }
      it 'ひらがなで答える' do
        expect(user.greet).to eq 'ぼくはたろうだよ'
      end
    end
    context '12歳以上の場合' do
      let(:age) { 13 }
      it '漢字で答える' do
        expect(user.greet).to eq '私はたろうです'
      end
    end
  end
end
# letは遅延評価される
# userってなんだ？paramsってなんだ？ageってなんだ？のように必要になってから呼ばれる

# No2
RSpec.describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }

    # テスト対象のオブジェクトが一つの場合はsubjectを使う
    # subjectを使って、オブジェクトを一箇所にまとめる
    subject { user.greet }

    context '12歳以下の場合' do
      let(:age) { 12 }
      it 'ひらがなで答える' do
        is_expected.to eq 'ぼくはたろうだよ'
      end
    end
    context '12歳以上の場合' do
      let(:age) { 13 }
      it '漢字で答える' do
        is_expected.to eq '私はたろうです'
      end
    end
  end
end

# No3(No3のリファクタリング)
RSpec.describe User do
  describe '#greet' do
    let(:user) { User.new(params) }
    let(:params) { {name: 'たろう', age: age} }

    # テスト対象のオブジェクトが一つの場合はsubjectを使う
    # subjectを使って、オブジェクトを一箇所にまとめる
    subject { user.greet }

    context '12歳以下の場合' do
      let(:age) { 12 }
      # itを省略
      # it is_expected to eq 'ぼくはたろうだよ'みたいに英語っぽく記述できる
      it { is_expected.to eq 'ぼくはたろうだよ'}
    end
    context '12歳以上の場合' do
      let(:age) { 13 }
      it { is_expected.to eq '私はたろうです'}
    end
  end
end

# No4(No3のリファクタリング)
RSpec.describe User do
  describe '#greet' do
    let(:user) { User.new(name: 'たろう', age: age) }
    subject { user.greet }
    context '12歳以下の場合' do
      let(:age) { 12 }
      it { is_expected.to eq 'ぼくはたろうだよ'}
    end
    context '13歳以上の場合' do
      let(:age) { 13 }
      it { is_expected.to eq '私はたろうです'}
    end
  end
end
