# Proyecto SCARA – Universidad Militar Nueva Granada

Este repositorio contiene el desarrollo completo de un robot manipulador tipo **SCARA**, desde el diseño mecánico en SolidWorks hasta su modelado cinemático, su simulación en Matlab, su descripción en formato URDF y la sintonización del control de posición de sus servomotores. El objetivo del proyecto es diseñar, modelar y simular un brazo SCARA accionado por servomotores y una articulación prismática que permita una implementación precisa.

El robot tiene **3 grados de libertad**: dos articulaciones rotacionales ($\theta_1$, $\theta_2$) y una prismática ($d_3$).

## Estructura del repositorio

| Carpeta | Contenido |
|---|---|
| [`1. Piezas y Ensambles SolidWorks`](./1.%20Piezas%20y%20Ensambles%20SolidWorks) | Piezas individuales (`.SLDPRT`) y ensamblajes (`.SLDASM`) del robot en SolidWorks, con y sin servomotor. |
| [`2. Planos`](./2.%20Planos) | Planos técnicos (`.SLDDRW`) de las piezas y del ensamblaje general, más su versión en PDF. |
| [`3.Cinematica_Directa`](./3.Cinematica_Directa) | Desarrollo y cálculo de la cinemática directa del robot, resuelta por dos métodos independientes (Matrices de Transformación Homogénea y Denavit–Hartenberg) que se contrastan entre sí. |
| [`4.Cinematica_Inversa`](./4.Cinematica_Inversa) | Desarrollo y cálculo de la cinemática inversa del robot mediante desacoplamiento geométrico (ley de cosenos para $\theta_1,\theta_2$ y despeje directo para $d_3$). |
| [`5. Matlab_Simscape`](./5.%20Matlab_Simscape) | Modelo y simulación del robot en Matlab/Simulink usando Simscape Multibody (cinemática directa e inversa animadas sobre el ensamble de SolidWorks) y [modelado del motor DC](./5.%20Matlab_Simscape/Modelado%20Motor%20DC/README.md) en Simscape. |
| [`6. Matlab_PeterCorke`](./6.%20Matlab_PeterCorke) | Cinemática inversa paso a paso y su verificación con el Robotics Toolbox de Peter Corke para Matlab (modelo DH con `SerialLink` y `fkine`). |
| [`7. URDF`](./7.%20URDF) | Descripción del robot en formato URDF exportada desde SolidWorks (complemento SW2URDF), con scripts en Python (yourdfpy y PyBullet) para visualizarla, moverla y validarla contra la cinemática. |
| [`8.Control_Motor`](./8.Control_Motor) | Sintonización del controlador de posición del servomotor: reglas de la literatura (modelo IPD), asignación de polos y método del relé, con la comparación de los cinco métodos. |

> 📌 Cada carpeta cuenta con su propio `README.md` explicando en detalle su contenido (las subcarpetas de `8.Control_Motor` también).

## Flujo del proyecto

```text
Diseño CAD (1, 2) ──► Cinemática analítica (3, 4) ──► Simulación y verificación (5, 6, 7) ──► Control del motor (8)
```

- Las **cinemáticas directa e inversa** (3 y 4) se contrastan con tres herramientas independientes: Simscape Multibody (5), el toolbox de Peter Corke (6) y el modelo URDF (7).
- La carpeta 8 retoma el modelado del motor DC de la carpeta 5, con los parámetros del servomotor del proyecto, y sintoniza el controlador de posición de cada articulación.

## Estado del proyecto

- [x] Diseño CAD de piezas y ensamblajes
- [x] Planos técnicos
- [x] Cinemática directa
- [x] Cinemática inversa
- [x] Simulación en Matlab (Simscape y Peter Corke)
- [x] Descripción URDF
- [x] Modelado y sintonización del control de los motores

## Requisitos

- **SolidWorks** (para abrir y editar los archivos `.SLDPRT` / `.SLDASM` / `.SLDDRW`), con los complementos *Simscape Multibody Link* y *SW2URDF* (instalador en `7. URDF/Exporter`) si se quiere exportar.
- **Matlab** con Simulink, Simscape (Multibody y Electrical) y Control System Toolbox, y el **Robotics Toolbox de Peter Corke** (`rvctools`, carpeta 6).
- **Python** con `yourdfpy`, `trimesh`, `pyglet` y `pybullet` para los scripts de la carpeta 7.
- **Git LFS**: los archivos pesados de SolidWorks y las mallas `.STL` están versionados con LFS (instalar `git lfs` antes de clonar).
