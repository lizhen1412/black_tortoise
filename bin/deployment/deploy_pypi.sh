#/bin/bash

function build_package() {
    echo "Building the package..."
    python3 -m pip install --upgrade setuptools wheel twine
    python3 setup.py sdist bdist_wheel
}

function upload_package() {
    read -p 'PyPI Username: ' user_var
    read -sp 'PyPI Password: ' pass_var
    echo
    echo "Uploading the package to PyPI..."
    # echo "${pass_var}" | twine upload --username "${user_var}" --password-stdin dist/*
    echo "Uploading the package to PyPI..."
    export TWINE_USERNAME="${user_var}"
    export TWINE_PASSWORD="${pass_var}"
    twine upload dist/*
}

function clean() {
    echo "Cleaning up..."
    rm -rf dist
    rm -rf build
    rm -rf *.egg-info
}

function cd_root() {
    cd "$(dirname "$0")"
    cd ../../
}

function check_venv() {
    if [ ! -d "venv" ]; then
        echo "venv not found, creating..."
        python3 -m venv venv
    fi
    source venv/bin/activate
}

function install_requirements() {
    echo "Installing requirements..."
    pip install -r requirements.txt
    python3 -m pip install --upgrade pip
}

function main() {
    cd_root
    clean
    check_venv
    install_requirements
    echo "Starting the packaging process..."
    build_package
    upload_package
    echo "Done."
}




main