# テーブル設計

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