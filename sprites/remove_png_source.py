import os
import argparse
import shutil


def process_folders(root_folder, folder_match):
    for folder_name in os.listdir(root_folder):
        if not os.path.isdir(os.path.join(root_folder, folder_name)):
            continue

        if folder_match and folder_match not in folder_name:
            continue

        input_folder = os.path.join(root_folder, folder_name, "PNG Sequences")
        if os.path.exists(input_folder):
            print(f"Removing folder: {input_folder}")
            shutil.rmtree(input_folder)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Remove PNG source images.")
    parser.add_argument("root_folder", type=str, help="Root folder to process.")
    parser.add_argument("-f", "--folder_match", type=str, default="", help="String to match folder names.")

    args = parser.parse_args()

    process_folders(args.root_folder, args.folder_match)
