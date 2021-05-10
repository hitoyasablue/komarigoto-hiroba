## アプリ名
困りごとひろば

## アプリの概要
困りごとひろばは、ユーザーの、主にメンタルに関する困りごとの緩和を目的としたアプリです。
ユーザーは今自分が持つ困りごとを投稿することができ、投稿は全てのユーザーに共有されます。
ユーザーは各投稿に対して「そうなんだ」「おうえん」などのリアクションをすることができ、
リアクションを受けたユーザーは通知ページでそれを知ることができます。

困りごと投稿の質問項目には例えば以下のようなものがあります。
- あなたが今感じていることを、なんでも記入してください
- がんばって生きている自分にどんな言葉をかけてあげたいですか？
- 理想の状態を10点とすると、今の状態は何点ですか？

## アプリURL
https://komarigotohiroba.com/

## アプリのスクリーンショット
<img src="https://user-images.githubusercontent.com/66470480/117677818-c37a4a80-b1e9-11eb-80b7-42461d8e0ff1.png" width="200px">
<img src="https://user-images.githubusercontent.com/66470480/117677831-c6753b00-b1e9-11eb-9fb9-5a4b05bf4ac7.png" width="200px">
<img src="https://user-images.githubusercontent.com/66470480/117677867-cd03b280-b1e9-11eb-8950-9879bff83d0e.png" width="200px">
<img src="https://user-images.githubusercontent.com/66470480/117677877-cf660c80-b1e9-11eb-92e8-2b996b37927d.png" width="200px">

## 使用した技術

### フロントエンド
- HTML
- CSS
- JavaScript
- bootstrap

### バックエンド
- Ruby
- Rails

### インフラ
- Git, Github
- MySQL
- Docker, docker-compose

### AWS
- ECS
- ECR
- RDS
- Route53
- ALB
- CloudWatch

### その他
- RSpec
- RuboCop


## 機能一覧
- ログイン, ログアウト, 簡単ログイン機能
- 投稿, 投稿一覧機能
- コメント機能
- いいね機能（ajax）
- 通知機能
- モーダルウィンドウによるSNS共有ボタン表示機能
- 検索機能
- ページネーション機能
- 運営への募金機能（クレジットカード情報登録機能, 振込機能）
- レスポンシブデザイン

## AWS構成図
![image](https://user-images.githubusercontent.com/66470480/117675907-fd4a5180-b1e7-11eb-9a03-d612043da824.png)

