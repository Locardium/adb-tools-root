import os
import zipfile

def zip_folder(folder_path, output_path):
    with zipfile.ZipFile(output_path, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(folder_path):
            # Exclude specific files/folders
            if '.git' in root:
                continue
            for file in files:
                if file.endswith('.zip') or file == 'zip_module.py' or file == '.gitignore':
                    continue
                file_path = os.path.join(root, file)
                # Calculate path relative to the folder
                arcname = os.path.relpath(file_path, folder_path)
                # Force forward slashes for Linux compatibility
                arcname = arcname.replace(os.sep, '/')
                zipf.write(file_path, arcname)

if __name__ == "__main__":
    zip_folder('E:\\Documents\\Proyectos\\Root\\wireless-adb', 'E:\\Documents\\Proyectos\\Root\\wireless-adb\\adb-tools-root.zip')
