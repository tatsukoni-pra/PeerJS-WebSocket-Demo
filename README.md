## [local] PeerJS Server 起動方法

```
$ docker compose up -d

$ curl http://localhost:9000/peerjs | jq
{
  "name": "PeerJS Server",
  "description": "A server side element to broker connections between PeerJS clients.",
  "website": "https://peerjs.com/"
}
```

## [local] WebRTC通信方法

1. ローカル環境用 PeerJS Server を起動する
2. `client/local_client_2.html` をブラウザで開く
3. `client/local_client_1.html` を別ブラウザで開くことで、ブラウザ間での接続が確立される
4. 相互にメッセージ送受信可能であることを確認する

## [Azure] WebRTC通信方法

1. Bicepを適用し、Azure App Service を作成する
2. `client/client_2.html` をブラウザで開く
3. `client/client_1.html` を別ブラウザで開くことで、ブラウザ間での接続が確立される
4. 相互にメッセージ送受信可能であることを確認する
