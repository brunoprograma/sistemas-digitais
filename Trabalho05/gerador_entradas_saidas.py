import random
from os.path import dirname, realpath, join
from PIL import Image

curr_path = join(dirname(realpath(__file__)), "files")


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


triangulos = [(Ponto(0, 0), Ponto(300, 0) , Ponto(0, 300)),
              (Ponto(800, 600), Ponto(800, 300) , Ponto(400, 600))]

larg, alt = 800, 600

img = Image.new("RGB", (larg, alt))

saidas = []

for x in range(larg):
    for y in range(alt):
        for t in triangulos:
            res = dentroTriang(Ponto(x, y), t)
            saidas.append((x, y, t, 1 if res else 0))
            if res:
                img.putpixel((x,y), (255, 255, 255))

lista_valores = random.sample(saidas, 500)
img.save(join(curr_path, "triangulos.png"), "PNG")

with open(join(curr_path, "entradas_triangulos.txt"), 'w') as entradas_triangulos:
    with open(join(curr_path, "saidas_triangulos.txt"), 'w') as saidas_triangulos:
        with open(join(curr_path, "entradas_sign.txt"), "w") as entradas_sign:
            with open(join(curr_path, "saidas_sign.txt"), "w") as saidas_sign:
                for (x, y, (p1, p2, p3), v) in lista_valores:
                    ponto = Ponto(x, y)
                    p1_p2, p2_p3, p3_p1 = sign(ponto, p1, p2), sign(ponto, p2, p3), sign(ponto, p3, p1)
                    entradas_triangulos.write("%d %d %d %d %d %d %d %d\n" % (x, y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y))
                    saidas_triangulos.write("%5d %5d %5d %5d %5d %5d %5d %5d = %d\n" % (x, y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y, v))
                    entradas_sign.write("%d %d %d %d %d %d %d %d\n" % (x, y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y))
                    saidas_sign.write("%5d %5d %5d %5d %5d %5d = %d\n" % (x, y, p1.x, p1.y, p2.x, p2.y, 1 if p1_p2 < 0 else 0))
                    saidas_sign.write("%5d %5d %5d %5d %5d %5d = %d\n" % (x, y, p2.x, p2.y, p3.x, p3.y, 1 if p2_p3 < 0 else 0))
                    saidas_sign.write("%5d %5d %5d %5d %5d %5d = %d\n" % (x, y, p3.x, p3.y, p1.x, p1.y, 1 if p3_p1 < 0 else 0))
