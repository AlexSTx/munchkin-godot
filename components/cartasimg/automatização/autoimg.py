from PIL import Image
import os

# Caminho da pasta com as imagens
folder_path = r'C:\Users\dwsol\OneDrive\Documentos\munchkin\munchkin-godot\components\cartasimg\Fundo-20241229T182258Z-001\Fundo'
# Define o novo tamanho para as imagens
new_size = (170, 250)

# Verifica se o caminho da pasta existe
if not os.path.exists(folder_path):
    print(f"O caminho {folder_path} não existe.")
else:
    print(f"O caminho {folder_path} é válido. Iniciando o processamento das imagens...")

    # Itera sobre todos os arquivos .png na pasta
    for filename in os.listdir(folder_path):
        if filename.endswith('.PNG'):
            img_path = os.path.join(folder_path, filename)
            print(f"Processando a imagem {filename}...")
            try:
                # Abre a imagem
                img = Image.open(img_path)
                
                # Redimensiona a imagem
                img = img.resize(new_size)
                
                # Salva a imagem novamente, removendo metadados e ajustando o formato PNG
                img.save(img_path, format='png', quality=95)  # Ajuste a qualidade conforme necessário
                print(f"Imagem {filename} processada e redimensionada com sucesso.")
            except Exception as e:
                print(f"Erro ao processar a imagem {filename}: {e}")

print("Processamento concluído.")
