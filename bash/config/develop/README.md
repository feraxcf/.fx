# `cecho` y `cerr` - Formateador de Texto y Colores en Bash

`cecho` (Color Echo) es un comando y función de utilidad para Bash que permite imprimir texto coloreado y formateado en la terminal utilizando una sintaxis de etiquetas similar a la de XML o al macro `cprint!` de Rust (por ejemplo: `cecho "Hola <r>mundo rojo</>"`). 

Está diseñado para ser **robusto, listo para producción y eficiente**, resolviendo los problemas comunes de los códigos de escape ANSI tradicionales, como la pérdida de estilos en el anidamiento, la contaminación de logs cuando se redirigen a archivos, y la compatibilidad con el estándar `NO_COLOR`.

Adicionalmente, se incluye `cerr` como una envoltura de conveniencia que redirige todo el texto formateado directamente al descriptor de error estándar (**stderr**).

---

## Características Principales

- **Sintaxis Simple**: Delimita colores y estilos mediante etiquetas de apertura `<etiqueta>` y cierre `</>` o específicas de estilo como `</bold>`.
- **Anidamiento con Pila de Estilos (Nesting Stack)**: Soporta múltiples niveles de anidamiento. Al cerrar una etiqueta con `</>`, el sistema reconstruye y aplica automáticamente el estado anterior de estilos de la pila sin perder formatos padres.
- **Soporte para Comas (Estilos Combinados)**: Puedes combinar múltiples estilos de golpe en una sola etiqueta (ej. `<bold, r, i>` para negrita, rojo y cursiva).
- **Escapado Flexible con `<<` y `>>`**: Imprime `<` y `>` literales duplicando los caracteres (ej. `<<a>>` imprime `<a>` de manera segura).
- **Manejo Inteligente de Caracteres Sueltos**: El analizador ignora caracteres `<` o `>` que no formen parte de una etiqueta bien estructurada o que no estén cerrados, imprimiéndolos literalmente sin romper la salida.
- **Seguridad en Producción (TTY & NO_COLOR)**: Detecta automáticamente si la salida es una terminal interactiva o si está siendo redirigida (a un archivo de log, un pipe o grep). Si se redirige o si existe la variable de entorno `NO_COLOR`, los códigos ANSI se limpian por completo automáticamente para mantener los logs de texto limpios.
- **Secuencias de Control**: Permite borrar líneas, limpiar pantallas y posicionar el cursor para realizar animaciones en tiempo real dentro de scripts de automatización.

---

## Sintaxis y Opciones

```bash
cecho [OPCIONES] [TEXTO]
```

### Opciones Soportadas
- `-n`: No imprime el salto de línea al final del texto. Es útil para imprimir mensajes en progreso (ej. "Cargando... [OK]").
- `-c` o `--force-color`: Fuerza el renderizado de colores e ignora si la salida no es un dispositivo TTY o si la variable de entorno `NO_COLOR` está presente.
- `-e`: Soportado por motivos de compatibilidad con el comando `echo` tradicional (se ignora internamente, ya que `cecho` siempre analiza los textos).

---

## Catálogo Completo de Etiquetas

Puedes usar cualquiera de estas etiquetas de manera independiente o combinada (ej. `<bold, i, br-g>Texto</>`).

### 1. Colores de Texto (Foreground)

| Nombre (Corto) | Estilo Normal | Nombre (Corto) | Estilo Brillante (Bright) |
| :--- | :--- | :--- | :--- |
| `k` | Negro | `bk` | Negro Brillante (Gris Oscuro) |
| `r` | Rojo | `br` | Rojo Brillante |
| `g` | Verde | `bg` | Verde Brillante |
| `y` | Amarillo | `by` | Amarillo Brillante |
| `b` | Azul | `bb` | Azul Brillante |
| `m` | Magenta | `bm` | Magenta Brillante |
| `c` | Cian | `bc` | Cian Brillante |
| `w` | Blanco | `bw` | Blanco Brillante |

### 2. Colores de Fondo (Background)

| Nombre | Fondo Normal | Nombre | Fondo Brillante (Bright) |
| :--- | :--- | :--- | :--- |
| `bg-k` | Fondo Negro | `bg-bk` | Fondo Negro Brillante |
| `bg-r` | Fondo Rojo | `bg-br` | Fondo Rojo Brillante |
| `bg-g` | Fondo Verde | `bg-bg` | Fondo Verde Brillante |
| `bg-y` | Fondo Amarillo | `bg-by` | Fondo Amarillo Brillante |
| `bg-b` | Fondo Azul | `bg-bb` | Fondo Azul Brillante |
| `bg-m` | Fondo Magenta | `bg-bm` | Fondo Magenta Brillante |
| `bg-c` | Fondo Cian | `bg-bc` | Fondo Cian Brillante |
| `bg-w` | Fondo Blanco | `bg-bw` | Fondo Blanco Brillante |

### 3. Estilos de Texto

| Etiqueta | Descripción |
| :--- | :--- |
| `bold` | Texto en **negrita** (grosor fuerte). |
| `dim` | Texto *atenuado* (brillo reducido o peso más delgado). |
| `i` | Texto en *cursiva* (*italic*). Requiere soporte del emulador de terminal. |
| `u` | Texto <u>subrayado</u> (*underline*). |
| `blink` | Texto parpadeante (algunos emuladores lo ignoran). |
| `rev` | Modo invertido (*reverse video*): intercambia el color del texto y del fondo. |
| `hide` | Oculta el texto (útil para campos sensibles o contraseñas). |
| `st` | Texto ~~tachado~~ (*strikethrough*). |

### 4. Cierres Parciales de Estilo (F6)

A diferencia del cierre genérico `</>` que apaga todos los estilos, puedes usar estas etiquetas para remover un estilo específico de la pila **sin alterar el resto de los colores aplicados**:

- `</bold>`: Desactiva únicamente la negrita.
- `</dim>`: Desactiva la atenuación.
- `</i>`: Desactiva la cursiva.
- `</u>`: Desactiva el subrayado.
- `</blink>`: Desactiva el parpadeo.
- `</rev>`: Desactiva el modo invertido.
- `</hide>`: Vuelve visible el texto oculto.
- `</st>`: Desactiva el tachado.

### 5. Temas Semánticos (F2)

Atajos rápidos preconfigurados para mantener la legibilidad y coherencia en scripts de automatización:

- `error`: Equivalente a texto rojo brillante en negrita (`<br, bold>`).
- `warn`: Equivalente a texto amarillo brillante en negrita (`<by, bold>`).
- `info`: Equivalente a texto cian brillante (`<bc>`).
- `success`: Equivalente a texto verde brillante en negrita (`<bg, bold>`).

### 6. Secuencias de Control (F5)

Acciones especiales para el control de la terminal interactiva. *Nota: No se guardan en la pila de estilos ya que son acciones instantáneas.*

- `clr-line`: Ejecuta un retorno de carro (`\r`) y borra toda la línea de la terminal. Ideal para barras de progreso.
- `clr-scr`: Limpia la pantalla por completo y reposiciona el cursor en la esquina superior izquierda.

---

## Ejemplos de Uso Detallados

A continuación, se detalla cómo exprimir al máximo el poder de `cecho`.

### 1. Colores y Estilos Básicos

La forma más directa de aplicar formato a palabras u oraciones específicas.

```bash
# Colores individuales básicos
cecho "Este es un <r>texto rojo</> y este es un <b>texto azul</>."

# Colores brillantes
cecho "Comparación: <r>Rojo normal</> vs <br>Rojo brillante</>."

# Múltiples estilos en cadena
cecho "<g>Verde</>, <y>Amarillo</>, <m>Magenta</>, <c>Cian</>, <w>Blanco</>."

# Texto con formato tipográfico
cecho "Texto con <bold>Negrita</>, <dim>Atenuado</>, <i>Cursiva</i> y <u>Subrayado</u>."
```

---

### 2. Combinación y Anidamiento Complejo (Pila)

`cecho` gestiona una pila de estados. Cuando anidas etiquetas, puedes usar la etiqueta de cierre genérica `</>` para volver al color del nivel superior, o un cierre parcial para mantener la cadena activa.

#### Ejemplo de Anidamiento Simple con `</>`:
```bash
cecho "Normal -> <g>Verde -> <r>Rojo anidado</> -> Regresamos a verde</> -> Normal."
```

#### Ejemplo con Múltiples Niveles de Profundidad:
```bash
cecho "<b>Azul <y>Amarillo <m>Magenta</> Amarillo otra vez</> Azul de nuevo</>"
```

#### Ejemplo de Cierre Parcial (`</bold>`, `</st>`, etc.):
El cierre parcial elimina el estilo solicitado de la pila, reconstruyendo los colores padres sin tener que resetearlo todo.
```bash
# Apaga solo la negrita manteniendo el color rojo de fondo/texto
cecho "<r, bold>Texto rojo y en negrita. </bold>Aquí sigue siendo rojo pero normal.</> Libre."

# Remueve el subrayado en un entorno azul
cecho "<b>Este texto es azul y <u>subrayado</u>, pero </u/>aquí ya no tiene subrayado y continúa en azul.</>"
```

#### Ejemplo Combinado de un Solo Golpe (usando comas):
```bash
cecho "<k, bg-y, bold, i>Texto negro sobre fondo amarillo brillante, en negrita y cursiva</>."
```

---

### 3. Escapado de Etiquetas y Símbolos Literales

En ocasiones necesitarás imprimir caracteres `<` y `>` literales. `cecho` maneja esto de forma inteligente.

#### Escapar con Dobles Símbolos (`<<` y `>>`):
Para imprimir etiquetas literales en la salida (como en manuales de usuario), duplica los caracteres.
```bash
# Imprime etiquetas literales sin que se interpreten
cecho "Usa <<b> para pintar texto de rojo. El cierre es <<//>>."
# Salida: Usa <b> para pintar texto de rojo. El cierre es </>.

cecho "El script de Rust usa el macro <<cprint!>> para dar color."
# Salida: El script de Rust usa el macro <cprint!> para dar color.
```

#### Caracteres Literales No Estructurados (Sin Escapar):
Si un `<` o `>` no representa una etiqueta cerrada o tiene formato incorrecto, el analizador lo imprime de forma literal. No es necesario escapar comparaciones lógicas o redirecciones estándar.
```bash
# Comparaciones numéricas (ignora el < porque no tiene etiqueta de cierre >)
cecho "Lógica matemática: 10 > 5 y 3 < 4."

# Uso de redirección estándar de shell
cecho "Guarda esto usando: echo hola > log.txt"

# Etiquetas desconocidas se mantienen intactas
cecho "Esta etiqueta <desconocida> no hace nada y se imprime tal cual."
cecho "Etiqueta malformada <a>> no causa error."
```

---

### 4. Opciones Especiales y Salidas de Error (`cerr`)

#### Evitar Saltos de Línea (`-n`):
```bash
cecho -n "<info>Cargando datos del servidor...</>"
sleep 1.5
cecho " <success>[Hecho]</>"
```

#### Enviar Mensajes a `stderr` (`cerr`):
En scripts profesionales, los mensajes normales van a `stdout` y los errores de sistema a `stderr`. `cerr` funciona exactamente igual que `cecho`, pero envía la salida al descriptor de error estándar.
```bash
# Imprime a stderr
cerr "<error>Error:</> El token de API proporcionado no es válido."
```

---

### 5. Casos de Uso Avanzados en Producción

#### Filtrado y Redirección Limpia (TTY & NO_COLOR):
`cecho` respeta el estándar para logs limpios. Si rediriges el output a un archivo o una tubería (`pipe`), las etiquetas ANSI se descartan de inmediato para no corromper la salida del archivo.

```bash
# Ejecutar cecho en consola:
cecho "<success>Operación exitosa</>"
# Muestra en la terminal: "Operación exitosa" en verde y negrita.

# Redirigir a un archivo:
cecho "<success>Operación exitosa</>" > output.log
# El archivo "output.log" contendrá exactamente el texto: "Operación exitosa" (sin códigos ANSI de control).

# Forzar colores en redirección (útil para comandos que leen ANSI como less):
cecho -c "<success>Operación exitosa</>" | less -R
```

#### Barra de Progreso Dinámica y Animaciones en una Sola Línea:
Gracias a la secuencia de control `<clr-line>` y a la opción `-n`, puedes actualizar una misma línea en la terminal sin llenar la pantalla de texto innecesario.

```bash
# Simulación de un proceso de instalación con barra de progreso interactiva
for i in {10..100..10}; do
    cecho -n "<clr-line><info>Cargando recursos...</> [<b>$i%</>]"
    sleep 0.3
done
cecho "\n<success>Instalación completada exitosamente.</>"
```

#### Mensajes de Diagnóstico Profesional usando Etiquetas Semánticas:
```bash
#!/bin/bash
# Script de despliegue simulado

cecho "<clr-scr><info>[1/3] Inicializando entorno de producción...</>"
sleep 1

if [[ -f "./config.json" ]]; then
    cecho "<success>[OK] Archivo config.json detectado.</>"
else
    cecho "<warn>[ALERTA] Archivo config.json ausente. Usando plantilla por defecto.</>"
fi

cecho "<info>[2/3] Conectando a la base de datos...</>"
sleep 1.5

# Simular error
cerr "<error>[ERROR] Conexión fallida a db_user@localhost (Timeout).</>"
cecho "<info>[3/3] Despliegue abortado debido a errores.</>"
```

---

## Compatibilidad del Emulador de Terminal

Dado que `cecho` depende de secuencias de escape ANSI SGR estándar, funciona perfectamente en el 99% de las terminales modernas en Linux y macOS, incluyendo:
- GNOME Terminal / Tilix / Console (Linux)
- iTerm2 / Terminal.app (macOS)
- Alacritty / Kitty (Multiplataforma)
- xterm / urxvt (Linux)
- VS Code Integrated Terminal
- Windows Terminal (usando WSL o Git Bash)
