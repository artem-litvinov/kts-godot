import os
import argparse
from PIL import Image


def process_folders(root_folder, folder_match):
    for folder_name in os.listdir(root_folder):
        if not os.path.isdir(os.path.join(root_folder, folder_name)):
            continue

        if folder_match and folder_match not in folder_name:
            continue

        input_folder = os.path.join(root_folder, folder_name)
        if not os.path.exists(input_folder):
            print(f"Path not found: {input_folder}")
            continue

        images = [img for img in os.listdir(input_folder) if img.endswith(".png")]

        for img in images:
            img_path = os.path.join(input_folder, img)
            try:
                with Image.open(img_path) as image:
                    width, height = image.size
                    if height < 900:
                        print(f"Skipping image {img_path} with height {height}")
                        continue

                    new_size = (width // 2, height // 2)
                    resized_image = image.resize(new_size, Image.Resampling.LANCZOS)
                    resized_image.save(img_path)
                    print(f"Resized image {img_path} to {new_size[0]}x{new_size[1]}")
            except Exception as e:
                print(f"Error processing image {img_path}: {e}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Downsize images to half their original size.")
    parser.add_argument("root_folder", type=str, help="Root folder to process.")
    parser.add_argument("-f", "--folder_match", type=str, default="", help="String to match folder names.")

    args = parser.parse_args()

    process_folders(args.root_folder, args.folder_match)
