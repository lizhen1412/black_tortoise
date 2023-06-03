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
python3 -m pip install --user --upgrade setuptools wheel twine

# 如果有虚拟环境报错执行
python3 -m pip install --upgrade setuptools wheel twine


# 打包项目
python3 setup.py sdist bdist_wheel

# 检查包是否合规
twine check dist/*

# 上传包至 pypi.org
twine upload dist/*

```