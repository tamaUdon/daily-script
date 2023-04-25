#!/bin/zsh

# コマンドラインオプションとして整数を受け取る
if [ $# -eq 0 ]; then
    echo "使用法: $0 分数"
    exit 1
elif ! [[ $1 =~ ^[0-9]+$ ]]; then
    echo "エラー: 引数には整数を指定してください。"
    exit 1
fi

# タイマーの設定 (引数で指定された分数を秒に変換)
timer_seconds=$(($1 * 60))

# カウントダウン関数
countdown() {
    local seconds=$1
    while [ $seconds -gt 0 ]; do
        # カウントダウン表示 (分:秒)
        local display_time=$(printf "%02d:%02d" $((seconds / 60)) $((seconds % 60)))
        osascript -e "display notification \"残り時間: $display_time\" with title \"タイマー\""
        sleep 600
        seconds=$((seconds - 600))
    done
}

# タイマー開始
echo "タイマーを開始します。経過時間: $1分"
countdown $timer_seconds

# タイマー終了時の通知
echo "タイマーが終了しました。"
osascript -e 'display notification "タイマーが終了しました。" with title "タイマー通知"'

