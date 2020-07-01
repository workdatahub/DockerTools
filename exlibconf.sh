#!/bin/bash

#  バイナリ実行ファイルにダイナミックリンクされている
#  共有ライブラリをリスト化してファイルに書き出します。
#
#  - 使い方 - 
#  ./exlibconf.sh [出力先ファイル名]
#
#  Designed On 2020.05 By kurukurumaware

LF="
"

var_libdirconfig=`cat /etc/ld.so.conf`
# 初期値
var_libDirList="/etc/ld.so.conf"$LF

# configファイル処理

#function configProcess(){
#    local var_dirList=`cat $1`
#while read var_line; do
#    local var_dir="${var_line# *}"
#    if [[ "$var_dir" = \#* ]]; then
#        :
#    else
#        var_libDirList=${var_libDirList}${var_dir}$LF
#    fi
#done << END
#    $var_dirList
#END
#}

# .confファイル検索処理
function configSearch(){

local var_configDir=$1
local var_configList=`ls $var_configDir`

while read var_line; do
    var_libDirList=${var_libDirList}${var_configDir}${var_line}$LF
#    configProcess "${var_configDir}${var_line}"
done << END
    $var_configList
END

}

# include処理
function includeProcess(){
    local var_configStr1=$1
    local var_configStr2="${var_configStr1#include *}"
    # *.confの処理
    if [[ "$var_configStr2" = *\*.conf ]]; then
        local var_includeDir="${var_configStr2%\*.conf}"
        configSearch "$var_includeDir"
    fi
}

function libsearch(){
while read var_line; do
    local var_trim1="${var_line# *}"
    local var_configStr="${var_trim1%* }"
    if [[ "$var_configStr" = \#* ]]; then
        :
    elif [[ "$var_configStr" = include* ]]; then
        includeProcess "$var_configStr"
    elif  [[ "$var_configStr" = *.conf ]]; then
        var_libDirList=${var_libDirList}${var_configStr}$LF
    fi
done << END
    $var_libdirconfig
END
}

libsearch

printf "%s\n" $var_libDirList
printf "%s\n" $var_libDirList > $1