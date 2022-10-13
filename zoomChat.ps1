###############################################
# zoomのチャットファイルからコメントのみを取り出して，
# - 匿名のコメントオンリーファイル（表示・共有用）
#   zoomのChatのパス/000/comment.txt
# - UTF-8BOM付きCSVファイル
#   zoomのChatのパス/最後に作られたフォルダ/meeting.csv
# をリアルタイムで生成・作成するスクリプト。
#################### 使い方 ####################
# 1.OBSのテキストボックスを追加してスクロール設定で
#   「コメントオンリーファイル（000/comment.txt）」に
#  リンクする
# 2. zoomを開始して、なんでもいいので発言する
#   （何か発言しないとチャットファイルが作られない）
# 3. このスクリプトを動かす
# 4. zoom参加者へメッセージの設定を「自分宛」の
#    ダイレクトメッセージにしてもらい、自由に
#    発言してもらう
# 5. zoomが終了したらこのスクリプトを止める
###########################################

$zoomPath = "==zoomアプリのレコーディングの保存場所==";
# zoomアプリケーションの「設定」を開き（歯車マーク）
# 「レコーディング」を開いてください（◉のマーク）
# レコーディングの保存場所にある文字列をコピーして「"」の間に
# 貼り付けしてください
# mac の場合は
#　　　$zoomPath="/Users/ユーザー名/Documents/Zoom";
# windows の場合は
#　　　$zoomPath="C:\Users\ユーザー名\Documents\Zoom";
# の様になると思います。

$folderDelimiter = "/";
$folderDelimiter = "\"; #mac ユーザーはこの行を消してください

# 「000」フォルダ（作業用フォルダ）がない場合は作る
# 名前は「000」である必要はありませんが
# 一番下のフォルダを元にこのスクリプトは動くので
# zoomが生成するフォルダよりも前におかないといけない
if (!(Test-Path $zoomPath)) {
	mkdir $zoomPath + $folderDelimiter + "000";
}

$comment = $zoomPath + $folderDelimiter + "000" + $folderDelimiter + "comment.txt";

# 一番最後に作られたフォルダを取得
$folderList = Get-ChildItem -Path $zoomPath;
foreach ($lastFolder in $folderList) {}

# 一番最後に作られたフォルダを取得のチャットファイルを設定
$filePath = $lastFolder.FullName + $folderDelimiter + "meeting_saved_chat.txt";
# チャットの差分ファイルを作成
New-Item -Path $diffFile -ItemType File -Force;
# 抽出コメントのファイルを作成
New-Item -Path $comment -ItemType File -Force;
# CSVファイルを作成
$csvpath = $lastFolder.FullName + $folderDelimiter + "meeting.csv";
New-Item -Path $csvpath -ItemType File -Force;
Write-Output "時刻,送信者,送り先,コメント" > $csvpath;

# 最後の参照行を設定
$prevTotalLine=0;

# shift-Tで終了を案内
Write-Host "このスクリプトを止める時は ShiftキーとTキーを入力してください";

while ($true){
	# 現在のチャットファイルの最終行数を取得
	$nowTotalLine=(Get-Content -Path $filePath).Length;
	# 最後の参照行数と最終行が同じ場合は（追加のコメントがない）処理をしない
	if ($nowTotalLine -gt $prevTotalLine){
		# 最終行-参照行数 を計算し差分行数を取得
		$diffLine=$nowTotalLine - $prevTotalLine;
		# チャットファイルの最終行から差分行数分を取得して差分ファイルへ書き込み
		$diffArray = Get-Content -Path $filePath -Tail $diffLine;
		# 差分ファイルを一行づつ読み込み
		foreach ($line in $diffArray){
			# 読み込んだ行の初めが時刻かどうかを判断
			if ($line -match "^[0-2][0-9]:[0-6][0-9]:[0-6][0-9]\ (開始|From)\ .*\ (から|To)\ .*:"){
				# CSV用変数に「時刻，送信者，送り先」を代入
				$line = ($line -replace "\s(開始|から|From|To)\s","`t") -replace "（.*）:$|\(.*\)$","";
				$lineArray=$line.Split("`t");
				# CSV用変数に「時刻，送信者，送り先」を代入
				$CSVstr = $lineArray[0] + "," + $lineArray[1] + "," + $lineArray[2];
			} else {
				# コメントの場合
				# トリミングしてCSV用変数にコメントを追加
				$line = $line.Trim("　 `t");
				$CSVstr=$CSVstr+"," + $line;
				# CSVファイルにCSV変数を追記
				Write-Output $CSVstr >> $csvpath;
				# コメントファイルにコメントのみを追記
				Write-Output $line >> $comment;
			}
		}
		$prevTotalLine=$nowTotalLine;
	}
	Start-Sleep -Seconds 0.1;
	$pressKey = [System.Console]::ReadKey();
	if($pressKey.Key -eq "T" -and $pressKey.Modifiers -eq "Shift"){exit;}
}