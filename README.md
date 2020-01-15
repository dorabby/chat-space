# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|username|string|null:false|
|email|string|null:false|
|password|string|null:false|
## Association
- has_many :chats
- has_many :groups_users
- has_many :groups, through: :user_id

## groupテーブル
|Column|Type|Options|
|------|----|-------|
|groupname|string|null:false|
|user_id|integer|null: false,foreign_key: true|
## Asociation
- has_many :chats
- has_many :groups_users
- has_many :users, through: :group_id

## chatsテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|image|text||
|user_id|integer|null: false,foreign_key: true|
|group_id|integer|null: false,foreign_key: true|
## Asociation
- belong_to :group
- belong_to :user

## groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user