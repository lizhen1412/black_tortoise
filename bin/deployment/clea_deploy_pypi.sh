# 跳转到根目录
change_to_root_directory() {
    echo "正在跳转到根目录..."
    cd $(dirname $0)
    cd ../..
}

# 清理文件夹
clean_up() {
    echo "正在清理文件夹..."
    rm -rf dist
    rm -rf build
    rm -rf *.egg-info
}


main() {
    change_to_root_directory
    clean_up
}

main
