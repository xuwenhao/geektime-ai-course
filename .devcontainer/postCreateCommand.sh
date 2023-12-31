#!/bin/bash
python -m venv ~/venv
echo "source ~/venv/bin/activate" >> ~/.zshrc
source /home/vscode/venv/bin/activate
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
pip install -r requirements.txt
sudo chown vscode:vscode /workspace