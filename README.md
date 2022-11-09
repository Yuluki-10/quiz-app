# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Design
- [figmaによるデザインカンプ](https://www.figma.com/file/HDVdW9OUTb78ap4BXXGNXM/%E6%A1%88%E4%BB%B6%E3%83%87%E3%82%B6%E3%82%A4%E3%83%B3?node-id=0%3A1)

* Ruby version
```
% ruby -v
ruby 3.0.3p157 (2021-11-24 revision 3fb7d2cadc) [arm64-darwin20]
```

* System dependencies

* Configuration

- Rails 6.1.6.1
- bundler 2.2.33

* 使用方法

このアプリケーションを動かす場合は、まずはリポジトリを手元にクローンしてください。
その後、次のコマンドで必要になる RubyGems をインストールします。

```
$ gem install bundler -v 2.2.33
$ bundle _2.2.33_ config set --local without 'production'
$ bundle _2.2.33_ install
```

その後、データベースへのマイグレーションを実行します。

```
$ rails db:migrate
```

最後に、テストを実行してうまく動いているかどうか確認してください。

```
$ rails test
```

テストが無事に通ったら、Railsサーバーを立ち上げる準備が整っているはずです。

```
$ rails server
```

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
