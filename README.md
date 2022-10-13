# zoomChatExtract
## 概要
- zoomのチャットファイルからコメント部分のみを抜き出して、コメントファイルを作成します。
- zoomのチャットファイルを「時刻,送信者,送り先,コメント」のBOM付きCSVファイルに変換し、チャットフォルダに保存します。
## 作成の目的
zoomで送られるチャットを整理してExcel上でソートできるようにCSVファイルへ変換したい
zoomのチャットコメントを匿名で画面に表示させたい
## 使い方
### 事前準備
1. このスクリプトをダウンロードして実行可能なところへ置く(自分のダウンロードフォルダもしくはユーザーフォルダ直下に置くと簡単)
1. このスクリプトの21行目、zoomPath変数にzoomのチャットファイルが作られるフォルダのパスを設定する
- zoomアプリケーションの「設定」を開き（歯車マーク）
- 「レコーディング」を開いてください（◉のマーク）
- レコーディングの保存場所にある文字列をコピーして「"」の間に貼り付けしてください
  - mac の場合は
    $zoomPath="/Users/ユーザー名/Documents/Zoom"
  - windows の場合は
    $zoomPath="C:\Users\ユーザー名\Documents\Zoom";
  の様になると思います。
1. 32, 33行目について mac, Linuxユーザーは33行目を削除するか先頭に「#」を付けてコメントアウトしてください
1. OBSのテキストボックスにスクロール設定で 「/Users/ユーザー名/Zoom/000/comment.txt」にリンクして、配信画面を作成する
1. zoomのカメラ設定をOBSにする
### 使用方法
1. OBSを開いて「仮想カメラ」をオンにする
1. zoomのカメラをOBSにする
1. zoomを開いてチャットに何かコメントを入れる（コメントを書き込まないとそのzoomのチャットファイルが作成されない）
1. ターミナルなどからこのシェルスクリプトを動かす
    - Mac, Linuxの場合
        ```
        pwsh このスクリプトのパス/zoomChat.ps1 #macの場合
        # pwsh ~/zoomChat.ps1 #ユーザーフォルダ直下に置いた場合
        # pwsh ~/Downloads/zoomChat.ps1 #ダウンロードフォルダから開く場合
    ```
    - Windowsの場合
      - スクリプトを右クリック
      - Powershellで実行
1. zoom参加者のメッセージ設定を、自分宛のダイレクトメッセージに変えてもらう
1. zoom参加者へ自由にチャットで発言してもらう
1. zoomが終了したらこのスクリプトを終了する
## 現時点の問題点
zoomのコメントファイルは、何か書き込まれるたびに追記されるわけではなく、不定期のタイミングで追記されるようだ。そのため、完全なリアルタイム同期はできていない。
## 今後に追加したい機能
1. NGワードの伏字設定
1. 1. オンライン授業でテストを行う場合などに使いたい
1. 1. 誹謗中傷などに該当する言葉を表示させない
1. NGアカウントの設定
