# zoomChatExtract
## 概要
- zoomのチャットファイルからコメント部分のみを抜き出して、コメントファイルを作成します。
- zoomのチャットファイルを「時刻,送信者,送り先,コメント」のCSVファイルに変換し、チャットフォルダに保存します。
## 作成の目的
- zoomで送られるチャットを整理してExcel上でソートできるようにCSVファイルへ変換したい
- zoomのチャットコメントを匿名で画面に表示させることで、コメントのしやすさを促し、コメント内容の共有を行う
## 使い方
### 事前準備
1. zoomのチャットファイルが作られるフォルダに 「000」という名前のフォルダを作成しておく<br>Macの場合はデフォルトで「~/Documents/Zoom/」
1. このスクリプトの13行目、zoomPath変数にzoomのチャットファイルが作られるフォルダのパスを設定する<br>Macの場合はデフォルトで「~/Documents/Zoom/」
1. OBSのテキストボックスをスクロール設定で 「~/Documents/Zoom/000/comment.txt」にリンクして、配信画面を作成する
1. zoomのカメラ設定をOBSにする
### 使用方法
1. zoomを開いてチャットに何かコメントを入れる（コメントを書き込まないとそのzoomのチャットファイルが作成されない）
1. ターミナルからこのシェルスクリプトを動かす
```
sh このスクリプトのパス/zoomChat.sh
```
1. zoomの参加者には自分宛のダイレクトメッセージでチャットを送信してもらう
1. zoomが終了したらこのスクリプトを終了する
## 現時点の問題点
zoomのコメントファイルは、何か書き込まれるたびに追記されるわけではなく、不定期のタイミングで追記されるようだ。そのため、完全なリアルタイム動機はできていない。
## 今後に追加したい機能
1. NGワードの伏字設定
    1. オンライン授業でテストを行う場合などに使いたい
    1. 誹謗中傷などに該当する言葉を表示させない
1. NGアカウントの設定
