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
|name|string|null:false|
|email|string|null:false|
|password|string|null:false|
## Association
- has_many :messages
- has_many :group_users
- has_many :groups, through: :group_users

## groupテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
## Asociation
- has_many :messages
- has_many :group_users
- has_many :users, through: :group_users

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text||
|image|text||
|user_id|integer|null: false,foreign_key: true|
|group_id|integer|null: false,foreign_key: true|
## Asociation
- belong_to :group
- belong_to :user

## group_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user
