# README

Chatwork APIを利用するサンプル  
とりあえずGETのみ

## Token設定

以下にChatworkで取得したtokenを設定する

app/controllers/chatwork_controller.rb
```
API_TOKEN = 'xxxxx'
```

```get_from_chatwork``` の引数のエンドポイントを変更することでGETをサンプル的に使える  
http://developer.chatwork.com/ja/endpoints.html

以下にアクセスし、ログを確認する（確認画面などは作ってない）  
http://localhost:3000/  
