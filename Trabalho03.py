# Adaptado de https://github.com/wuerges/aula-sist-digitais-2016-1/blob/master/python/point_in_triangle.py
from PIL import Image

class Ponto:
    def __init__(self, x, y):
        self.x = x
        self.y = y

def sign(p1, p2, p3):
    return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y)

def dentroTriang(ponto, triangulo):
    (v1, v2, v3) = triangulo
    teste1 = sign(ponto, v1, v2) < 0
    teste2 = sign(ponto, v2, v3) < 0
    teste3 = sign(ponto, v3, v1) < 0

    return teste1 == teste2 and teste2 == teste3

triangulos = [(Ponto(10, 10), Ponto(200,100) , Ponto(300,300)),
              (Ponto(400, 400), Ponto(700,400) , Ponto(700,600))]

larg, alt = 800, 600
img = Image.new("RGB", (larg, alt))

entradas  = []
saidas = []

for x in range(larg):
    for y in range(alt):
        for t in triangulos:
            res = dentroTriang(Ponto(x, y), t)
            entradas.append((x, y))
            saidas.append(res)
            if res:
			    img.putpixel((x,y), (141,32,174))

img.save("imagem.png", "PNG")

print(entradas)
print(saidas)
