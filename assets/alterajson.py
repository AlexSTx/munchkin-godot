import json
import re

# Função para adicionar o atributo "CAMINHO" a cada objeto no JSON
def adicionar_caminho(json_file, output_file):
    try:
        # Ler o arquivo JSON existente
        with open(json_file, 'r', encoding='utf-8') as file:
            conteudo = file.read()
        
        # Corrigir as barras invertidas não escapadas
        conteudo = re.sub(r'(?<!\\)\\(?!["\\/bfnrt])', r'\\\\', conteudo)
        
        # Parsear o conteúdo JSON
        dados = json.loads(conteudo)

        # Adicionar o atributo "CAMINHO" a cada objeto
        for item in dados:
            item["CAMINHO"] = ""

        # Salvar o arquivo JSON atualizado
        with open(output_file, 'w', encoding='utf-8') as file:
            json.dump(dados, file, indent=4, ensure_ascii=False)
        
        print(f"Arquivo atualizado salvo como {output_file}")
    
    except Exception as e:
        print(f"Ocorreu um erro: {e}")

# Exemplo de uso
json_file = r'C:\Users\dwsol\OneDrive\Documentos\munchkin\munchkin-godot\assets\cartas_munchkin.json'  # Nome do arquivo JSON existente
output_file = r'C:\Users\dwsol\OneDrive\Documentos\munchkin\munchkin-godot\assets\cartas_munchkin.json01'  # Nome do arquivo JSON atualizado

adicionar_caminho(json_file, output_file)
