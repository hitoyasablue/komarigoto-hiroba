## アプリ名
困りごとひろば

## アプリの概要
困りごとひろばは、ユーザーの困りごとの緩和を目的としたアプリです。
ユーザーは今自分が持つ困りごとを投稿することができ、投稿は全てのユーザーに共有されます。
ユーザーは各投稿に対して「そうなんだ」「おうえん」などのリアクションをすることができ、
リアクションを受けたユーザーは通知ページでそれを知ることができます。

困りごと投稿の質問項目には例えば以下のようなものがあります。
- 今どんなことに困っていますか？
- あなたが今感じていることを、なんでも記入してください
- がんばって生きている自分にどんな言葉をかけてあげたいですか？

## アプリURL
https://komarigotohiroba.com/

## アプリのスクリーンショット
<img src="https://user-images.githubusercontent.com/66470480/117677818-c37a4a80-b1e9-11eb-80b7-42461d8e0ff1.png" width="700px">
<img src="https://user-images.githubusercontent.com/66470480/117677831-c6753b00-b1e9-11eb-9fb9-5a4b05bf4ac7.png" width="700px">
<img src="https://user-images.githubusercontent.com/66470480/117679367-2c15f700-b1eb-11eb-850c-1be1d1f3a979.png" width="700px">

## 使用した技術
- Ruby 2.7.1
- Ruby on Rails 6.0.3.2
- MySQL 5.7
- Git, Github
- Docker, docker-compose
- RSpec
- RuboCop
- AWS
  - ECS（fargate）
  - ECR
  - RDS
  - Route53
  - ALB
  - CloudWatch

## 機能一覧
- ログイン, ログアウト機能
- 投稿, 投稿一覧機能
- コメント機能
- いいね機能（ajax）
- 通知機能
- モーダルウィンドウによるSNS共有ボタン表示機能
- 検索機能（ransack）
- ページネーション機能（kaminari）
- 運営への募金機能（Stripe）
- レスポンシブデザイン

## AWS構成図
![image](https://user-images.githubusercontent.com/66470480/117675907-fd4a5180-b1e7-11eb-9a03-d612043da824.png)

