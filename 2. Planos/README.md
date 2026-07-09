# 2. Planos

Esta carpeta contiene los planos técnicos del robot SCARA, generados a partir de las piezas de SolidWorks (`.SLDDRW`), junto con su versión exportada en PDF.

## Convención de ejes

La asignación de los ejes de referencia se realizó siguiendo la convención de un sistema cartesiano de mano derecha. El eje X se orientó hacia el frente del manipulador (dirección del efector final), el eje Z se estableció en la dirección vertical positiva y el eje Y quedó determinado por la regla de la mano derecha.

## Sistema de nomenclatura

Los archivos siguen el formato `[Prefijo]-[Código]_[Nombre].[Extensión]`, usando los mismos códigos de elemento definidos en la carpeta [`1. Piezas y Ensambles SolidWorks`](../1.%20Piezas%20y%20Ensambles%20SolidWorks) para que sea fácil relacionar cada plano con su pieza correspondiente.

<div align="center">

| Prefijo | Significado |
|---|---|
| `PLN-` | Plano en SolidWorks (`.SLDDRW`) |
| `PDF-` | Versión exportada en PDF del mismo plano |

</div>

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
| `08` | Ensamblaje completo del robot |

</div>

## Contenido

<div align="center">

| Archivo | Descripción |
|---|---|
| `PLN-00_BaseFija.SLDDRW` | Plano de la base fija (pieza sin servomotor). |
| `PLN-01_Eslabon1.SLDDRW` | Plano del eslabón 1 (pieza base, sin tapa, soporte ni servo). |
| `PLN-02_Eslabon2.SLDDRW` | Plano del eslabón 2 (pieza base, sin tapa, piñón ni servo). |
| `PLN-03_Piñon.SLDDRW` | Plano del piñón. |
| `PLN-04_Cremallera.SLDDRW` | Plano de la cremallera. |
| `PLN-05_TapaEslabon.SLDDRW` | Plano de la tapa usada en los eslabones. |
| `PLN-06_SoporteServo.SLDDRW` | Plano del soporte del servomotor. |
| `PLN-08_EnsambleCompleto.SLDDRW` | Plano general del ensamblaje completo del robot. |

</div>

## Carpeta `PDF/`

Contiene la exportación en PDF de cada uno de los planos anteriores (con el prefijo `PDF-` en lugar de `PLN-`), para consulta rápida sin necesidad de abrir SolidWorks.

## Notas

- Estos planos corresponden a las piezas **base** de cada elemento (sin tapa, sin soporte y sin servomotor), no a las versiones "Completo"/"ConServo" que se usan para la simulación en Matlab. Esas piezas están documentadas en la carpeta [`1. Piezas y Ensambles SolidWorks`](../1.%20Piezas%20y%20Ensambles%20SolidWorks).
- El código de cada plano coincide con el código de su pieza/ensamblaje correspondiente en la carpeta de Piezas y Ensambles, para facilitar la trazabilidad entre ambas carpetas.