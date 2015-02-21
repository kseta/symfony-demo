#!/bin/bash

# PLUGINS=で始まってる行をコメントアウトしたり追加したりして、
# 好きなプラグインをインストールできるよ。
# まぁ、普通は、JenkinsのWeb UIから「プラグインの管理」でインストールすればいいと思う。
# 同じ環境を何個も作りたい場合はこのスクリプトをどうぞ。

PLUGINS=()

# Jenkin Build Pipeline Plugin
# タスクのパイプラインを見やすくできる
# 参考:http://www.ryuzee.com/contents/blog/4470
PLUGINS=("${PLUGINS[@]}" "build-pipeline-plugin")

# Hudson Cron Column Plugin
# どのタスクがいつ実行されるかを見やすくできる
PLUGINS=("${PLUGINS[@]}" "cron_column")

# git Plugin
# gitと連携させるならどうぞ
PLUGINS=("${PLUGINS[@]}" "git")

# Jenkins Job Configuration History Plugin
# 設定の変更履歴を取得することができる
PLUGINS=("${PLUGINS[@]}" "jobConfigHistory")

# Plot Plugin
# 好きなものをグラフ化できるプラグイン
PLUGINS=("${PLUGINS[@]}" "plot")

# Email ext Plugin
# メール通知拡張
PLUGINS=("${PLUGINS[@]}" "email-ext")
PLUGINS=("${PLUGINS[@]}" "checkstyle")
PLUGINS=("${PLUGINS[@]}" "pmd")
PLUGINS=("${PLUGINS[@]}" "dry")
PLUGINS=("${PLUGINS[@]}" "clover")
PLUGINS=("${PLUGINS[@]}" "jdepend")
PLUGINS=("${PLUGINS[@]}" "xunit")

# コマンドの成功失敗を判定する関数。
# インストールにはあまり関係ない
function check()
{
    local result=$?
    local red=$'\e[0;31m'
    local green=$'\e[0;32m'
    local default=$'\e[m'
    if [ $result -eq 0 ]; then
        echo -n $green
        echo $@ OK
        echo -n $default
        return 0
    else
        echo -n $red
        echo $@ Fail
        echo -n $default
        return 1
    fi
}

function exit_check(){
  if ! check $@; then
    echo exit
    exit 1
  fi
}

function usage(){
  echo usage
  echo $0 \$JENKINS_URL
  echo or
  echo export JENKINS_URL=URL \&\& $0
  echo
  echo ex.1\)
  echo $0 http://localhost:8080
  echo ex.2\)
  echo export JENKINS_URL=http://localhost:8080 \&\& $0
}

if [ -n "$1" ]; then
  JENKINS_URL=$1
elif [ -z "$JENKINS_URL" ]; then
  usage >&2
  exit 1
fi

case $JENKINS_URL in
  http*)
    ;;
  *)
    usage >&2
    exit 1
    ;;
esac


# コマンドラインでプラグインインストールに必要なjenkins-cliを取得
wget -O jenkins-cli.jar $JENKINS_URL/jnlpJars/jenkins-cli.jar
exit_check get jenkins-cli

# プラグインのインストール
for (( I = 0; I < ${#PLUGINS[@]}; ++I ))
do
  install_plugin=${PLUGINS[$I]}
  java -jar jenkins-cli.jar -s $JENKINS_URL install-plugin $install_plugin
  check install $install_plugin
done

# Jenkinsの再起動
java -jar jenkins-cli.jar -s $JENKINS_URL safe-restart
check Jenkins restart
