import os
import argparse
import re
from PIL import Image


def merge_images_horizontally(image_folder, output_image_path):
    # List all PNG files in the folder
    images = [img for img in os.listdir(image_folder) if img.endswith(".png")]

    # Open images in RGBA mode and calculate total width and max height
    image_objects = [Image.open(os.path.join(image_folder, img)).convert("RGBA") for img in images]
    widths, heights = zip(*(img.size for img in image_objects))

    total_width = sum(widths)
    max_height = max(heights)

    # Create a new image with the calculated dimensions and a transparent background
    merged_image = Image.new("RGBA", (total_width, max_height), (0, 0, 0, 0))

    # Paste images one by one into the new image
    x_offset = 0
    for img in image_objects:
        merged_image.paste(img, (x_offset, 0), img)
        x_offset += img.width

    # Save the merged image with transparency
    merged_image.save(output_image_path)


def to_snake_case(name):
    name = re.sub(r"[\s\-]+", "_", name)  # Replace spaces and hyphens with a single underscore
    name = re.sub(r"(?<!^)(?=[A-Z])", "_", name).lower()  # Add underscores before capital letters and lowercase the name
    name = re.sub(r"_{2,}", "_", name)  # Replace multiple underscores with a single underscore
    return name


def process_folders(root_folder, folder_match):
    for folder_name in os.listdir(root_folder):
        if not os.path.isdir(os.path.join(root_folder, folder_name)):
            continue

        if folder_match and folder_match not in folder_name:
            continue

        input_folder = os.path.join(root_folder, folder_name, "PNG Sequences")

        if not os.path.exists(input_folder):
            print(f"Path not found: {input_folder}")
            continue

        subfolders = [f.path for f in os.scandir(input_folder) if f.is_dir()]

        for subfolder in subfolders:
            subfolder_name = os.path.basename(subfolder)
            snake_case_subfolder_name = to_snake_case(subfolder_name)
            output_image_path = os.path.join(root_folder, folder_name, f"{snake_case_subfolder_name}.png")
            merge_images_horizontally(subfolder, output_image_path)
            print(f"Merged image saved to: {output_image_path}")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Merge PNG images horizontally.")
    parser.add_argument("root_folder", type=str, help="Root folder to process.")
    parser.add_argument("-f", "--folder_match", type=str, default="", help="String to match folder names.")

    args = parser.parse_args()

    process_folders(args.root_folder, args.folder_match)
