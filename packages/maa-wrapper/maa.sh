# 路径
maa_root="$HOME/Games/maa"
maa_bin_root="$maa_root/current"
maa_bin="$maa_bin_root/MAA.exe"
config_file="$maa_bin_root/config/gui.json"

echo maa_root="$maa_root"
echo maa_bin_root="$maa_bin_root"
echo maa_bin="$maa_bin"
echo config_file="$config_file"

maa_cmd="env GAMEID=maa umu-run $maa_bin"
echo maa_cmd="$maa_cmd"

# 从配置文件中提取当前地址
current_address=""
if [ -f "$config_file" ]; then
    # 使用grep和sed提取地址值
    current_address=$(grep '"Connect.Address":' "$config_file" | sed -n 's/.*"Connect.Address": "\([^"]*\)".*/\1/p')
fi

# 使用kdialog获取用户输入的地址，默认值为配置文件中的当前地址
new_address=$(kdialog --title "输入ADB地址" --inputbox "请输入ADB地址 (host:port格式，可选):" "$current_address")

# 检查用户是否输入了地址（点击OK且输入不为空）
if [ $? -eq 0 ] && [ -n "$new_address" ]; then
    # 执行adb连接
    adb connect "$new_address"

    # 检查adb连接是否成功
    if [ $? -eq 0 ]; then
        # 更新配置文件中的地址
        if [ -f "$config_file" ]; then
            # 使用sed替换配置文件中的地址
            sed -i "s/\"Connect.Address\": \".*\"/\"Connect.Address\": \"$new_address\"/" "$config_file"
            # kdialog --title "成功" --msgbox "ADB地址已更新为: $new_address"
        else
            kdialog --title "警告" --sorry "配置文件未找到: $config_file"
        fi
    else
        kdialog --title "错误" --error "ADB连接失败: $new_address"
    fi
fi

# 无论是否输入地址，都执行以下命令
# kdialog --title "信息" --passivepopup "正在设置MAA环境..." 3

# 创建adb符号链接
ln -sf "$(which adb)" -t "$maa_root" -v

# 检查ln命令是否成功
if [ $? -ne 0 ]; then
    kdialog --title "错误" --error "创建adb符号链接失败"
    exit 1
fi

# 设置安卓设备分辨率
adb shell wm size 1080x1920
if [ $? -ne 0 ]; then
    kdialog --title "警告" --warningyesno "设置分辨率失败，是否继续运行MAA？"
    if [ $? -ne 0 ]; then
        exit 1
    fi
fi

# 启动MAA
$maa_cmd

# 检查umu-run是否成功
if [ $? -ne 0 ]; then
    kdialog --title "错误" --error "MAA出现错误"
fi

# 无论MAA运行结果如何，都重置分辨率
adb shell wm size reset
if [ $? -ne 0 ]; then
    kdialog --title "警告" --sorry "重置分辨率失败"
fi