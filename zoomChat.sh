#!/bin/sh

##########################################
# zoomのチャットファイルからコメントのみを
# 取り出して，匿名のコメントファイルを作成する
# 
# 1. zoomのチャットファイルが作られるフォルダに
#  「000」という名前のフォルダを作成しておく
# 2. OBSのテキストボックスにスクロール設定で
#  「000/comment.txt」をリンクする
###########################################

zoomPath="zoomのChatファイルが作られるフォルダのパス"
diffFile=${zoomPath}"000/diff.txt"
comment=${zoomPath}"000/comment.txt"

# 一番最後に作られたフォルダを取得
for lastFolder in ${zoomPath}*
do
	:
done

# 一番最後に作られたフォルダを取得のチャットファイルを設定
filePath=${lastFolder}"/meeting_saved_chat.txt"
# チャットを整理するCSVファイルのパスを設定
csvPath=${lastFolder}"/meeting.csv"

# 空のCSVファイルを作成
cp /dev/null "${csvPath}"
# チャットの差分ファイルを作成
cp /dev/null "${diffFile}"
# 抽出コメントのファイルを作成
cp /dev/null "${comment}"

# 最後の参照行を設定
prevTotalLine=0

while :
do
	# 現在のチャットファイルの最終行を取得
	nowTotalLine=`cat "${filePath}"|wc -l`

	# 最後の参照行数と最終行が同じ場合は（追加のコメントがない）処理をしない
	if [ ${nowTotalLine} -gt ${prevTotalLine} ]; then
		# 最終行-参照行数 を計算し差分行数を取得
		diffLine=$((${nowTotalLine} - ${prevTotalLine}))
		# チャットファイルの最終行から差分行数分を取得して差分ファイルへ書き込み
		tail -n ${diffLine} "${filePath}" > "${diffFile}"
	
		# 差分ファイルを一行づつ読み込み
		while read line
		do
			# 読み込んだ行の初めが時刻かどうかを判断
			if [[ ${line} =~ ^[0-2][0-9]:[0-6][0-9]:[0-6][0-9]\ 開始\ .*\ から\ .*: ]]; then
				# 時刻の場合
				# 時刻を取り出し
				timeLine=${line%" 開始 "*}
				sendline=${line#*" 開始 "}
				# チャット送信者を取り出し
				senderName=${sendline%" から "*}
				StrLine=${line##*" から "}
				# チャット送り先を取り出し
				recieverName=(${StrLine//:/ })
				# CSV用変数に「時刻，送信者，送り先」を代入
				CSVstr=${timeLine}","${senderName}","${recieverName}
			else
				# コメントの場合
				# CSV用変数にコメントを追加
				CSVstr=${CSVstr}","${line}
				# CSVファイルにCSV変数を追記
				echo ${CSVstr} >> "${csvPath}"
				# コメントファイルにコメントのみを追記
				echo ${line} >> ${comment}
			fi
		done < "${diffFile}"
		prevTotalLine=${nowTotalLine}
	fi
	sleep 0.1
done