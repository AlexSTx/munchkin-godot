class Grafo:
    def __init__(self, vertices):
        self.vertices = vertices
        self.arestas = []

    def adicionar_aresta(self, u, v, peso):
        self.arestas.append([u, v, peso])

    def encontrar(self, parent, i):
        if parent[i] == i:
            return i
        return self.encontrar(parent, parent[i])

    def unir(self, parent, rank, x, y):
        raiz_x = self.encontrar(parent, x)
        raiz_y = self.encontrar(parent, y)

        if rank[raiz_x] < rank[raiz_y]:
            parent[raiz_x] = raiz_y
        elif rank[raiz_x] > rank[raiz_y]:
            parent[raiz_y] = raiz_x
        else:
            parent[raiz_y] = raiz_x
            rank[raiz_x] += 1

    def kruskal(self):
        resultado = []
        i = 0
        e = 0

        self.arestas = sorted(self.arestas, key=lambda item: item[2])
        parent = []
        rank = []

        for node in range(self.vertices):
            parent.append(node)
            rank.append(0)

        while e < self.vertices - 1:
            u, v, peso = self.arestas[i]
            i = i + 1
            x = self.encontrar(parent, u)
            y = self.encontrar(parent, v)

            if x != y:
                e = e + 1
                resultado.append([u, v, peso])
                self.unir(parent, rank, x, y)

        print("As arestas na árvore geradora mínima são:")
        for u, v, peso in resultado:
            print(f"{u} -- {v} == {peso}")

# Exemplo de uso:
g = Grafo(6)  # Número de vértices
g.adicionar_aresta(0, 1, 4)  # A - E
g.adicionar_aresta(0, 3, 3)  # A - D
g.adicionar_aresta(1, 5, 2)  # E - F
g.adicionar_aresta(5, 2, 2)  # F - C
g.adicionar_aresta(4, 5, 5)  # B - F
# Arestas adicionais
g.adicionar_aresta(0, 4, 1)  # A - B (exemplo)
g.adicionar_aresta(1, 2, 4)  # E - C (exemplo)
g.adicionar_aresta(2, 3, 3)  # C - D (exemplo)
g.adicionar_aresta(3, 4, 6)  # D - B (exemplo)

g.kruskal()
