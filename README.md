# Proyecto-Teoria-Computacion-I
Proyecto de teoria de automatas finitos para Teoria de la computacion

Dependencias
- [Love2d](https://love2d.org/) v11.3 (Motor de videojuegos)
- [Lua](https://www.lua.org/home.html) v5.3.5 (Lenguaje de programación)
- [Luarocks](https://luarocks.org/) v3.3.1 (Gestor de paquetes para Lua)
- [love-release](https://luarocks.org/modules/rucikir/love-release) (Para crear los ejecutables del juego tanto para Windows 32/64 bits y GNU/Linux)

# Ejecutar y crear ejecutables

Los ejecutables se crean en la carpeta releases. Para windows se generan dos zips uno para 32 y otro para 64 bits. Descomprime el necesario
segun tu sistema y dentro habra un exe, ejecutalo.


Para Linux se genera un deb
```bash
# Para correr el juego ejecuta el siguiente comando en la raiz del proyecto
love .

# Para generar los ejecutables desde linux. Se generan en la carpeta releases.
./build.sh # Esto funciona para linux y genera tanto los ejecutables de Windows y Linux

# Para generar los ejecutables desde Windows. Se generan en la carpeta releases.
rm -r releases

love-release -D # Este genera el ejecutable de Linux
love-release -W 32 #Este genera el ejecutable de Windows 32 bits
love-release -W 64 #Este genera el ejecutable de Windows 64 bits
```

# Controles

- W o ↑ para moverse hacia arriba.
- S o ↓ para moverse hacia abajo.
- A o ← para moverse a la izquierda.
- D o → para moverse a la derecha.
- R para reiniciar el juego.
- La tecla escape para suicidar al personaje con fines de prueba.
