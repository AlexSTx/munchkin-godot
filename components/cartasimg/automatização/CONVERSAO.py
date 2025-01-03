import os
from PIL import Image

# Diretório contendo as imagens .TIF
input_directory = r'C:\Users\dwsol\OneDrive\Documentos\munchkin\munchkin-godot\components\cartasimg\Slots-20250103T142627Z-001'  # Altere para o diretório correto
output_directory = r'C:\Users\dwsol\OneDrive\Documentos\munchkin\munchkin-godot\components\cartasimg\imagens_png01'  # Diretório para salvar as imagens .PNG

# Certifique-se de que o diretório de saída existe
if not os.path.exists(output_directory):
    os.makedirs(output_directory)
    print(f"Diretório de saída criado: {output_directory}")
else:
    print(f"Diretório de saída já existe: {output_directory}")

# Converter todos os arquivos .TIF para .PNG
for filename in os.listdir(input_directory):
    if filename.lower().endswith('.tif'):
        try:
            img_path = os.path.join(input_directory, filename)
            print(f"Tentando abrir o arquivo: {img_path}")
            img = Image.open(img_path)
            basename = os.path.splitext(filename)[0]
            output_path = os.path.join(output_directory, f'{basename}.png')
            img.save(output_path, 'PNG')
            print(f'Convertido: {filename} -> {basename}.png')
        except Exception as e:
            print(f"Erro ao converter {filename}: {e}")

print("Conversão concluída!")
