# 1. Piezas y Ensambles SolidWorks

Esta carpeta contiene todas las piezas (`.SLDPRT`) y ensamblajes (`.SLDASM`) del diseño CAD del robot SCARA.

## Convención de ejes

La asignación de los ejes de referencia se realizó siguiendo la convención de un sistema cartesiano de mano derecha. El eje X se orientó hacia el frente del manipulador (dirección del efector final), el eje Z se estableció en la dirección vertical positiva y el eje Y quedó determinado por la regla de la mano derecha.

Los orígenes de las piezas coinciden con el punto donde se aplican las relaciones de posición en el ensamblaje (por ejemplo, en la interfaz con el servomotor), para asegurar coherencia entre todas las piezas del sistema.

## Sistema de nomenclatura

Los archivos siguen el formato `[Prefijo]-[Código]_[Nombre]_[Estado].[Extensión]`:

**Prefijos:**

<div align="center">

| Prefijo | Significado |
|---|---|
| `PZA-` | Pieza individual |
| `ASM-` | Ensamblaje |

</div>

**Códigos por elemento:**

<div align="center">

| Código | Elemento |
|---|---|
| `00` | Base fija |
| `01` | Eslabón 1 |
| `02` | Eslabón 2 |
| `03` | Piñón |
| `04` | Cremallera |
| `05` | Tapa de eslabón |
| `06` | Soporte del servo |
| `07` | Servo horn / servo genérico |
| `08` | Ensamblaje completo del robot |

</div>

## Base fija

<div align="center">

| Archivo | Descripción |
|---|---|
| `PZA-00_BaseFija_SinServo.SLDPRT` | Cuerpo de la base fija, sin servomotor. |
| `PZA-00_BaseFija_ConServo.SLDPRT` | Base fija con servomotor integrado. Exportada como pieza única desde `ASM-00_BaseFija_ConServo.SLDASM` para simplificar el modelo de cara a Matlab. |
| `ASM-00_BaseFija_ConServo.SLDASM` | Ensamblaje de la base fija con su servomotor. |

</div>

## Eslabón 1

<div align="center">

| Archivo | Descripción |
|---|---|
| `PZA-01_Eslabon1_Base.SLDPRT` | Cuerpo del eslabón 1, sin tapa, sin soporte de servo y sin servo. |
| `PZA-01_Eslabon1_Completo.SLDPRT` | Eslabón 1 con tapa, soporte y servomotor integrados. Exportada como pieza única desde `ASM-01_Eslabon1_ConServo.SLDASM` para simplificar el modelo de cara a Matlab. |
| `ASM-01_Eslabon1_ConServo.SLDASM` | Ensamblaje del eslabón 1 con tapa, soporte y servomotor. |

</div>

## Eslabón 2

<div align="center">

| Archivo | Descripción |
|---|---|
| `PZA-02_Eslabon2_Base.SLDPRT` | Cuerpo del eslabón 2, sin tapa, sin piñón y sin servo. |
| `PZA-02_Eslabon2_Completo.SLDPRT` | Eslabón 2 con tapa, piñón y servomotor integrados. Exportada como pieza única desde `ASM-02_Eslabon2_ConServo.SLDASM` para simplificar el modelo de cara a Matlab. |
| `ASM-02_Eslabon2_ConServo.SLDASM` | Ensamblaje del eslabón 2 con tapa, piñón y servomotor. |

</div>

## Piñón

<div align="center">

| Archivo | Descripción |
|---|---|
| `PZA-03_Piñon.SLDPRT` | Piñón individual. |
| `PZA-03_Piñon_6Horn.SLDPRT` | Piñón con los 6 horns del servomotor integrados, exportado como pieza única desde `ASM-03_Piñon_6Horn.SLDASM`. |
| `ASM-03_Piñon_6Horn.SLDASM` | Ensamblaje del piñón con los 6 horns del servomotor. |

</div>

## Otros componentes

<div align="center">

| Archivo | Descripción |
|---|---|
| `PZA-04_Cremallera.SLDPRT` | Cremallera del sistema piñón-cremallera. |
| `PZA-05_TapaEslabon.SLDPRT` | Tapa usada en los eslabones. |
| `PZA-06_SoporteServo.SLDPRT` | Soporte del servomotor. |
| `PZA-07_ServoHorn.SLDPRT` | Servo horn individual. |
| `ASM-07_ServoGenerico.SLDASM` | Ensamblaje genérico del servomotor, sin la pieza a la que se acopla. |

</div>

## Ensamblaje completo

<div align="center">

| Archivo | Descripción |
|---|---|
| `ASM-08_EnsambleCompleto.SLDASM` | Ensamblaje completo del robot: base fija, eslabón 1, eslabón 2 y cremallera, usando las mínimas relaciones de posición posibles para mantener el modelo simple. |

</div>

## Notas de diseño

- Las piezas "Completo" / "ConServo" simplifican el modelo (reducen número de componentes y relaciones) para facilitar su exportación a Matlab.
- El ensamblaje completo busca usar el menor número de relaciones de posición posible, priorizando simplicidad sobre precisión de mating, ya que el objetivo es un modelo cinemático funcional y no una validación mecánica exhaustiva.