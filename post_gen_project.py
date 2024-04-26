import os

def rename_file():
    # Chemin vers le fichier à renommer dans le répertoire généré
    old_file_path = "agnes"
    # Nouveau nom du fichier
    new_file_name = "{{cookiecutter.__command_slug}}"
    # Renommer le fichier
    os.rename(old_file_path, new_file_name)

if __name__ == '__main__':
    rename_file()

