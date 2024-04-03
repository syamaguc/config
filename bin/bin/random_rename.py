#!/usr/bin/env python3

import sys
import os
import random
import string
from pathlib import Path


def random_string(length):
    """ランダムな文字列を生成する関数"""
    letters = string.ascii_lowercase
    return "".join(random.choice(letters) for _ in range(length))


def rename_files(folder_path):
    """指定されたフォルダ内のファイル名をランダムに変更する関数"""
    folder = Path(folder_path)
    for file_path in folder.iterdir():
        # ファイルの拡張子を取得
        _, extension = os.path.splitext(file_path)

        # 新しいランダムなファイル名を生成
        new_name = folder / (random_string(8) + extension)

        # ファイルの移動・名前変更
        file_path.rename(new_name)
        print(f"Renamed {file_path} to {new_name}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python random_rename.py [folder_path]")
        sys.exit(1)
    else:
        folder_path = sys.argv[1]
        home_dir = Path.home()
        # folder_path = home_dir / "config" / "wallpaper"
        rename_files(folder_path)
