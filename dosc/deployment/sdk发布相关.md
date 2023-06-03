### black_tortoise sdk 发布 pypi.org 流程 ###

###### 发布流程 ######
```shell
# 如果没有虚拟环境，创建虚拟环境
python3 -m venv venv

# 激活虚拟环境
source venv/bin/activate

# 安装 依赖 库
pip install -r requirements.txt

# 确保pip 是最新版本
python3 -m pip install --upgrade pip

# 安装 setuptools wheel twine 至最新版本
# python3 -m pip install --user --upgrade setuptools wheel twine

# 如果有虚拟环境报错执行
python3 -m pip install --upgrade setuptools wheel twine


# 打包项目
python3 setup.py sdist bdist_wheel

# 检查包是否合规
twine check dist/*

# 上传包至 pypi.org
twine upload dist/*

```

###### 构建发布 脚本
```shell
# 环境变量
# 默认上传地址是: https://upload.pypi.org/legacy/


export TWINE_REPOSITORY_URL=your_private_repository_url
export TWINE_USERNAME=your_username
export TWINE_PASSWORD=your_password
```

###### 上传脚本
存放地址在: bin/deployment/deploy_pypi.sh
```shell
#!/bin/bash

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

# 检查并创建虚拟环境
check_and_create_venv() {
    echo "正在检查并创建虚拟环境..."
    if [ ! -d "venv" ]; then
        python3 -m venv venv
    fi
}

# 激活虚拟环境
activate_venv() {
    echo "正在激活虚拟环境..."
    source venv/bin/activate
}

# 安装必要的库
install_requirements() {
    echo "正在安装必要的库..."
    pip install -r requirements.txt
}

# 更新 pip
upgrade_pip() {
    echo "正在更新pip..."
    python3 -m pip install --upgrade pip
}

# 安装打包库
install_packaging_tools() {
    echo "正在安装打包工具..."
    python3 -m pip install --upgrade setuptools wheel twine
}

# 打包项目
package_project() {
    echo "正在打包项目..."
    python3 setup.py sdist bdist_wheel
}

# 检查是否合规
check_dist() {
    echo "正在检查打包结果是否符合要求..."
    twine check dist/*
}

# 上传包
upload_package() {
    echo "正在上传包..."
    TWINE_REPOSITORY_URL=${TWINE_REPOSITORY_URL}
    TWINE_USERNAME=${TWINE_USERNAME}
    TWINE_PASSWORD=${TWINE_PASSWORD}
    echo 上传地址是: ${TWINE_REPOSITORY_URL}
    twine upload --repository-url ${TWINE_REPOSITORY_URL} dist/* -u ${TWINE_USERNAME} -p ${TWINE_PASSWORD}
}

main() {
    change_to_root_directory
    clean_up
    check_and_create_venv
    activate_venv
    install_requirements
    upgrade_pip
    install_packaging_tools
    package_project
    check_dist
    upload_package
}

main

```