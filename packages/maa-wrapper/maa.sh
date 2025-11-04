# 路径
maa_root="$HOME/Games/maa"
maa_bin_root="$maa_root/current"
maa_bin="$maa_bin_root/MAA.exe"
config_file="$maa_bin_root/config/gui.json"

echo "maa_root=$maa_root"
echo "maa_bin_root=$maa_bin_root"
echo "maa_bin=$maa_bin"
echo "config_file=$config_file"

maa_cmd="env GAMEID=maa umu-run $maa_bin"
echo "maa_cmd=$maa_cmd"

# 创建adb符号链接
if ! ln -sf "$(which adb)" -t "$maa_root" -v; then
    kdialog --title "MAA" --error "创建adb符号链接失败"
    exit 1
fi

# 从配置文件中提取当前地址
current_address=""
if [ -f "$config_file" ]; then
    # 使用grep和sed提取地址值
    current_address=$(grep '"Connect.Address":' "$config_file" | sed -n 's/.*"Connect.Address": "\([^"]*\)".*/\1/p')
fi

# 使用kdialog获取用户输入的地址，默认值为配置文件中的当前地址
new_address=$(kdialog --title "MAA" --inputbox "请输入ADB地址 (host:port格式，可选):" "$current_address")

# 检查用户是否输入了地址（点击OK且输入不为空）
if [ $? -eq 0 ] && [ -n "$new_address" ]; then
    # 执行adb连接
    if adb connect "$new_address"; then
        # 更新配置文件中的地址
        if [ -f "$config_file" ]; then
            sed -i "s/\"Connect.Address\": \".*\"/\"Connect.Address\": \"$new_address\"/" "$config_file"
        else
            kdialog --title "MAA" --sorry "配置文件未找到: $config_file"
        fi
    else
        kdialog --title "MAA" --error "ADB连接失败: $new_address"
    fi
fi

# 无论是否输入地址，都执行以下命令

# 设置安卓设备分辨率
if ! adb -s "$new_address" shell wm size 1080x1920; then
    if ! kdialog --title "MAA" --warningyesno "设置分辨率失败，是否继续运行MAA？"; then
        exit 1
    fi
fi

# 启动MAA
if ! $maa_cmd; then
    kdialog --title "MAA" --error "MAA出现错误"
fi

# 重置分辨率
if kdialog --yesno "是否重置分辨率？"; then
    if ! adb -s "$new_address" shell wm size reset; then
        kdialog --title "MAA" --sorry "重置分辨率失败"
    fi
fi

# 断开连接
adb disconnect "$new_address"