# spec/spec/helper.rbの設定を読み込む
require 'spec_helper'

RSpec.describe Hello do
  # describeはテストのグループ化を宣言
  describe '四則演算' do
    # itはテストをexampleという単位でまとめることができる
    it '1 + 1 は 2 になること' do
      # expect(エクスペクテーションは期待するという意味)
      expect(1 + 1).to eq 2

      # shouldは稀に不具合が起こることがある
      # (1 + 1).should eq 2
    end

    it '10 - 1 は 9 になること' do
      expect(10 - 1).to eq 9
    end

    # itのなかに複数のエクスペクテーションを記述できる
    # exampleという単位は1つの単位であるため、どこかのエクスペクテーションでこけたら、その先のエクスペクテーションでこけても検知できない
    # 原則は1つのexampleにつき一つのエクスペクテーション
    it '全部できること' do
      expect(1 + 2).to eq 3
      expect(10 - 1).to eq 9
      expect(4 * 8).to eq 32
      expect(40 / 5).to eq 8
    end

    # describeはあくまでグループ化なのでネストもできる
    describe '足し算' do
      it '1+1は1' do
        expect(1 + 1).to eq 2
      end
    end
    describe '引き算' do
      it '10-1は9' do
        expect(10-1).to eq 9
      end
    end

  end
end

# No2
# RSpec.describe.User(文字列じゃなくてクラスも渡せる)
RSpec.describe User do
  # インスタンスメソッドのgreetをテストするよ
  describe '#greet' do
    it '12歳以下であれば、ひらがなで答える' do
      user = User.new(name: 'たろう', age: 12)
      expect(user.greet).to eq 'ぼくはたろうだよ'
    end
    it '12歳以上であれば、感じで答える' do
      user = User.new(name: 'たろう', age: 13)
      expect(user.greet).to eq '私はたろうです'
    end
  end
end

# No3(No2のリファクタ)
RSpec.describe User do
  describe '#greet' do
    # contextは場合分けのグルーピングで使う
    context '12歳以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(name: 'たろう', age: 12)
        expect(user.greet).to eq 'ぼくはたろうだよ'
      end
    end
    context '12歳以上の場合' do
      it '漢字で答えること' do
        user = User.new(name: 'たろう', age: 13)
        expect(user.greet).to eq '私はたろうです'
      end
    end
  end
end

# No4(No3のリファクタ)
RSpec.describe User do
  describe '#greet' do
    # beforeはit(example)の実行毎に呼ばれる
    # 共通処理やデータのセットアップで用いる
    before do
      # beforeとitはスコープが異なるため、インスタンス変数にハッシュ値を格納する
      @params = { name: 'たろう' }
    end
    context '12歳以下の場合' do
      it 'ひらがなで答えること' do
        user = User.new(@params.merge(age: 12))
        expect(user.greet).to eq 'ぼくはたろうだよ'
      end
    end
    context '12歳以上の場合' do
      it '漢字で答えること' do
        user = User.new(@params.merge(age: 13))
        expect(user.greet).to eq '私はたろうです'
      end
    end
  end
end

# No5(No4のリファクタ)
RSpec.describe User do
  describe '#greet' do
    before do
      @params = { name: 'たろう' }
    end
    context '12歳以下の場合' do
      before do
        @params.merge!(age: 12)
      end
      it 'ひらがなで答える' do
        user = User.new(@params)
        expect(user.greet).to eq 'ぼくはたろうだよ'
      end
    end
    context '12歳以上の場合' do
      before do
        @params.merge!(age: 13)
      end
      it '漢字で答える' do
        user = User.new(@params)
        expect(user.greet).to eq '私はたろうです'
      end
    end
  end
end
