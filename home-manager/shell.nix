{
  programs = {
    bash = {
      enable = true;
      enableCompletion = true;
      # initExtra = ''
      #   fish
      # '';
    };

    fish = {
      enable = true;
      functions = {
        whichreal = {
          body = "command realpath (which $argv)";
        };
        mvln = {
          body = ''
            if test (count $argv) -lt 2
                echo "用法:" (status current-function) "源文件... 目标目录" >&2
                return 1
            end

            set target $argv[-1]

            # 检查目标是否为目录（如果不是，报错）
            if not test -d $target
                echo "ERROR: 目标 '$target' 不是一个目录" >&2
                return 1
            end

            # 遍历所有源文件（除最后一个参数）
            for src in $argv[1..-2]
                if not test -e $src
                    echo "WARNING: '$src' 不存在，跳过" >&2
                    continue
                end

                # 如果是符号链接，跳过并不做任何操作
                if test -L $src
                    echo "WARNING: '$src' 是符号链接，跳过" >&2
                    continue
                end

                set basename (path basename $src)
                set dest_path $target/$basename

                # 移动文件
                if mv -i $src -T $dest_path
                    # 成功移动后，在原位置创建符号链接指向新位置
                    ln -s $dest_path $src
                else
                    # 移动失败：检查是否因为目标已存在
                    if test -e $dest_path
                        # 目标存在，询问用户是否创建链接指向它
                        read -l -P "目标 '$dest_path' 已存在。是否在原位置创建指向它的符号链接？(y/N) " reply
                        if string match -q -i "y" "$reply"
                            ln -sf $dest_path $src
                            echo "INFO: 已在 '$src' 创建指向 '$dest_path' 的符号链接。" >&2
                        else
                            echo "INFO: 跳过 '$src'。" >&2
                        end
                    else
                        echo "ERROR: 无法移动 '$src' 到 '$dest_path'" >&2
                    end
                end
            end
          '';
        };
      };
    };
  };
}
