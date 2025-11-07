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
                return
            end

            set target $argv[-1]

            # 检查目标是否为目录（如果不是，报错）
            if not test -d $target
                echo "ERROR: 目标 '$target' 不是一个目录" >&2
                return 1
            end

            # 遍历除最后一个参数外的所有源文件
            for src in $argv[1..-2]
                if test -e $src
                    set basename (path basename $src)
                    set dest_path $target/$basename

                    # 移动文件
                    mv $src $dest_path

                    # 在原位置创建指向新位置的符号链接
                    ln -s $dest_path $src
                else
                    echo "WARNING: '$src' 不存在，跳过" >&2
                end
            end
          '';
        };
      };
    };
  };
}
