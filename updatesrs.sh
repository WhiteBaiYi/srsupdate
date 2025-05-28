#!/bin/bash
Local_Path="$HOME/singbox/srs"
#来源
declare -A Update_Source=(
    ["senshinya"]="https://raw.githubusercontent.com/senshinya/singbox_ruleset/main/rule"
    ["Loyalsoldier"]="https://github.com/Loyalsoldier/geoip/raw/refs/heads/release/srs"
    )

declare -A Update_Files=(
    ["senshinya"]="Tencent Telegram WeChat BiliBili Steam"
    ["Loyalsoldier"]="ad cn"
    )
#逻辑区
if [ -d $Local_Path ]; then
    echo "文件夹存在，开始更新"
    echo "文件将会保存在$Local_Path目录下"
    for source_name in "${!Update_Source[@]}"; do
        base_url="${Update_Source[$source_name]}"
        for files in ${Update_Files[$source_name]}; do
            if [ "$source_name" = "senshinya" ]; then
                url="$base_url/$files/$files.srs"
                echo $url
            else
                url="$base_url/$files.srs"
                echo $url
            fi
            save_path="$Local_Path/$files.srs"
            echo -n "开始下载$files.srs ... " 
            curl -4 -fsSL "$url" -o "$save_path" && {
                echo "成功"
                continue
            } || {
                echo "失败"
            }
        done
    done
else
    echo "文件夹不存在，请手动创建$Local_Path"
fi
    echo "执行结束"
