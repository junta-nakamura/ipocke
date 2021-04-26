### データベース
MySQL

### ソース管理
GitHub,GitHubDesktop

### テスト
RSpec

### エディタ
VSCode

# DB設計

## ideasテーブル

| Column      | Type       | Options           |
| ----------- | ---------- | ----------------- |
| body        | text       | null: false       |
| category_id | references | foreign_key: true |

### Association

- belongs_to :category

## categoriesテーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| name   | string | null: false |

### Association

- has_many :ideas