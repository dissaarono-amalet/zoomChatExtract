# zoomChatExtract
## 概要
- zoomのチャットファイルからコメント部分のみを抜き出して、コメントファイルを作成します。
- zoomのチャットファイルを「時刻,送信者,送り先,コメント」のCSVファイルに変換し、チャットフォルダに保存します。
## 作成の目的
zoomで送られるチャットを整理してExcel上でソートできるようにCSVファイルへ変換したい
zoomのチャットコメントを匿名で画面に表示させたい
## 使い方
### 事前準備
1. zoomのチャットファイルが作られるフォルダに 「000」という名前のフォルダを作成しておく<br>Macの場合はデフォルトで「~/Documents/Zoom/」
1. このスクリプトの13行目、zoomPath変数にzoomのチャットファイルが作られるフォルダのパスを設定する<br>Macの場合はデフォルトで「~/Documents/Zoom/」
1. OBSのテキストボックスをスクロール設定で 「~/Documents/Zoom/000/comment.txt」にリンクして、配信画面を作成する
1. zoomのカメラ設定をOBSにする
### 使用方法
1. zoomを開いてチャットに何かコメントを入れる（コメントを書き込まないとそのzoomのチャットファイルが作成されない）
1. ターミナルからこのシェルスクリプトを動かす
> sh このスクリプトのパス/zoomChat.sh
1. zoomが終了したらこのスクリプトを終了する
