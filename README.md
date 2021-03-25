# アプリケーション名

## アウトプットベース

# アプリケーション概要

## このアプリケーションでは、学習した知識をアウトプットし共有することで、その知識を定着させ、形に残す事ができる。

# URL

## https://output-base.herokuapp.com/

# テスト用アカウント

## メールアドレス

### b@b

## パスワード

### 123456a

# 利用方法

## ログインした後に、アウトプット投稿のボタンを押すと投稿画面へ遷移する。

# 目指した課題解決

## 主に学生の学習した知識が形に残らず記憶にも残りにくいという課題を解決するために開発した。

# 洗い出した要件

## トップページ

- ログイン済みのとき

	- ボタン

		- ログアウトできるボタンが有る
		- アウトプット投稿ページへ遷移するボタンが有る
		- アウトプット検索ページへ遷移するボタンがある
		- アウトプット詳細ページへ遷移するボタンがある
		- マイページへ遷移するボタンがある

	- 表示

		- アウトプット一覧が表示される
		- アウトプットはタグごとに並ぶ

- ログインしていないとき

	- ボタン

		- ログイン/サインアップボタンがある

	- 表示

		- サービス説明が表示される

## サインアップ/ログインページ

- deviseで実装
- ログイン

	- メールアドレス
	- パスワード

- サインアップ

	- メールアドレス
	- ニックネーム
	- パスワード
	- パスワード確認
	- 職業
	- 生年月日

## アウトプット投稿ページ

- Action Textで実装

- ボタン

	- ログアウトできるボタンが有る
	- アウトプット検索ページへ遷移するボタンがある
	- マイページへ遷移するボタンがある
	- アウトプット投稿ページへ遷移するボタンがある
	- アウトプットを投稿できるボタンが有る
	- タグを選択するボタンが有る

- 表示

	- リッチテキストエディタで授業が投稿できる

## アウトプット編集ページ

- Action Textで実装

- もとの情報が表示されるように
- ボタン

	- ログアウトできるボタンが有る
	- アウトプット検索ページへ遷移するボタンがある
	- アウトプット投稿ページへ遷移するボタンがある
	- マイページへ遷移するボタンがある
	- アウトプットが編集できるボタンが有る

## アウトプット検索ページ

- ボタン

	- ログアウトできるボタンが有る
	- アウトプット検索ページへ遷移するボタンがある
	- アウトプット投稿ページへ遷移するボタンがある
	- マイページへ遷移するボタンがある
	- フリーワード検索できるボタンが有る
	- タグ検索できるボタンが有る

- 表示

	- フリーワード検索できるフォームがある
	- タグが一覧で並んでいてそれをクリックするとそのタグのアウトプットが一覧表示される

## アウトプット詳細ページ

- ボタン

	- 投稿者

		- アウトプット編集ページへ遷移するボタンが有る

	- 非投稿者

		- 高評価ボタンがある
		- コメント送信ボタンがある
		- アウトプット投稿者のマイページへ遷移するボタン

- 表示

	- アウトプットが表示される
	- コメント一覧が表示される
	- アウトプット投稿者の詳細が表示される

## マイページ

- ボタン

	- ログアウトできるボタンが有る
	- アウトプット検索ページへ遷移するボタンがある
	- アウトプット投稿ページへ遷移するボタンがある
	- アウトプット詳細ページへ遷移するボタンがある
	- マイページへ遷移するボタンがある

- 表示

	- 投稿したアウトプット一覧
	- もらった高評価総数
	- 本人のみ

		- 高評価したアウトプット一覧
		- 個人情報編集ページへ遷移するボタンがある

# 実装した機能

## トップページ
### 投稿されたアウトプットが一覧表示される

## サインアップ/ログインページ
### 最初にログインページへと遷移し、そこからサインアップページへと遷移できる

## アウトプット投稿ページ
### アウトプットをリッチテキストエディタで投稿できる

## アウトプット編集ページ
### アウトプットを編集できる

## アウトプット詳細ページ
### アウトプットを閲覧でき、コメントすることや、高評価をつける事ができる

# 実装予定の機能

## マイページ
### 高評価をつけたアウトプットが一覧表示される

## アウトプット検索ページ
### アウトプットをタグやフリーワードで検索できる

# データベース設計

## users テーブル

|Column            |Type   |Options                  |
|------------------|-------|-------------------------|
|nickname          |string |null: false              |
|email             |string |null: false, unique: true|
|encrypted_password|string |null: false              |
|job_id            |integer|null: false              |
|birthday          |date   |null: false              |

### Association

- has_many :posts
- has_many :comments
- has_many :goods
- has_many :liked_posts, through: :goods, source: :post

## posts テーブル

|Column   |Type      |Options                       |
|---------|----------|------------------------------|
|name     |string    |null: false                   |
|post_text|text      |null: false                   |
|user     |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- has_many   :comments
- has_many   :goods
- has_many   :liked_users,   through: :goods, source: :user
- has_many   :tags,          through: :post_tags

## tags テーブル

|Column|Type  |Options                  |
|------|------|-------------------------|
|name  |string|null: false, unique: true|

### Association

- has_many :posts, through: :post_tags

## post_tags テーブル

|Column|Type      |Options                       |
|------|----------|------------------------------|
|post  |references|null: false, foreign_key: true|
|tag   |references|null: false, foreign_key: true|

### Association

- belongs_to :post
- belongs_to :tag

## goods テーブル

|Column|Type      |Options                       |
|------|----------|------------------------------|
|user  |references|null: false, foreign_key: true|
|post  |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :post

## comments テーブル

|Column      |Type      |Options                       |
|------------|----------|------------------------------|
|comment_text|text      |null: false                   |
|user        |references|null: false, foreign_key: true|
|post        |references|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :post

# ローカルでの動作方法

## git cloneした後に以下のコードを実行する。

### rails db:create
### rails db:migrate

## バージョン

### ruby: 2.6.5
### rails: 6.0.0
