# <center>CIU - Práctica 9</center>

## Contenidos

* [Autoría](#autoría)
* [Introducción](#introducción)
* [Controles](#controles)
* [Implementación](#implementación)
* [Animación del programa](#animación-del-programa)
* [Referencias](#referencias)

## Autoría

Esta obra es un trabajo realizado por Benearo Semidan Páez para la asignatura de Creación de Interfaces de Usuario cursada en la ULPGC.

## Introducción

El objetivo de esta práctica consiste en hacer uso de shaders en Processing.
Para ello, usamos las especificaciones de OpenGL con su formato de shaders de fragmentos, <i>.glsl</i>.

Por otra parte, hacemos uso de los filtros generales existentes en Processing para ver su efecto.

Los filtros se aplican tanto al fondo al fondo como a los elementos introducidos en la aplicación, mientras que los shaders únicamente se aplican sobre objetos.

## Controles

| Acción | Resultado |
| -- | -- |
| Tecla 1 | Resetea el shader/filtro actualmente aplicado |
| Tecla 2 | Filtro de escala de grises |
| Tecla 3 | Filtro de inversión de color |
| Tecla 4 | Filtro de umbralizado |
| Tecla 5 | Filtro de posterizado (usa como parámetro levels 5) |
| Tecla 6 | Filtro de difuminado (usa como parámetro levels 5) |
| Tecla 7 | Filtro de erosión |
| Tecla 8 | Filtro de dilatación |
| Tecla 9 | Shader externo que genera una niebla azulada móvil |
| Tecla 0 | Shader propio que muestra los colores del arcoíris en movimiento |

## Implementación

La implementación consta de las siguientes partes:


* Muestra el cubo de muestra rotando y la imagen de fondo, así como el shader/filtro seleccionado:

```java
void draw() {
  background(BG);
  translate(width/2, height/2);
  rotateY(radians(rotation));
  rotation++;
  stroke(0);
  fill(0, 255, 0);
  box(100);
  showShader();
}
```

* Selección de shaders:

```java
void keyPressed() {
  switch(key) {
  case '1':
    setShader(null);
    break;
  case '2':
    setShader(GRAY);
    break;
  case '3':
    setShader(INVERT);
    break;
  case '4':
    setShader(THRESHOLD);
    break;
  case '5':
    setShader(POSTERIZE);
    break;
  case '6':
    setShader(BLUR);
    break;
  case '7':
    setShader(ERODE);
    break;
  case '8':
    setShader(DILATE);
    break;
  case '9':
    setShader(clouds);
    break;
  case '0':
    setShader(party);
    break;
  }
}

void setShader(int filter) {
  currentShader = null;
  currentFilter = filter;
}

void setShader(PShader shader) {
  currentFilter = NONE; // NONE = 404
  currentShader = shader;
}
```

* Muestra del filtro/shader y asiganación de parámetros:

```java
void showShader() {
  if (currentFilter == POSTERIZE || currentFilter == BLUR) {
    showShader(LEVELS);
    return;
  }
  resetShader();
  if (currentFilter != NONE && currentShader == null) {
    filter(currentFilter);
  } else if (currentShader != null && currentFilter == NONE) {
    currentShader.set("u_resolution", float(width), float(height));
    currentShader.set("u_time", millis() / 1000.0);
    shader(currentShader);
  }
}

void showShader(int levels) {
  resetShader();
  if (currentFilter != NONE && currentShader == null) filter(currentFilter, levels);
  else if (currentShader != null && currentFilter == NONE) {
    currentShader.set("u_resolution", float(width), float(height));
    currentShader.set("u_time", millis() / 1000.0);
    shader(currentShader);
  }
}
```

## Animación del programa

![GIF](animation/animation.gif)

## Referencias

- <b>[[Shader de niebla]](https://thebookofshaders.com/13/)</b>

- <b>[[Referencia de Processing - Filtros]](https://processing.org/reference/filter_.html)</b>
