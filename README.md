# Proyecto SCARA – Universidad Militar Nueva Granada

Este repositorio contiene el desarrollo completo de un robot manipulador tipo **SCARA**, desde el diseño mecánico en SolidWorks hasta su modelado cinemático y simulación en Matlab. El objetivo del proyecto es diseñar, modelar y simular un brazo SCARA accionado por servomotores y una articulación prismatica que permita una implementacion precisa.

## Estructura del repositorio

| Carpeta | Contenido |
|---|---|
| [`1. Piezas y Ensambles SolidWorks`](./1.%20Piezas%20y%20Ensambles%20SolidWorks) | Piezas individuales (`.SLDPRT`) y ensamblajes (`.SLDASM`) del robot en SolidWorks, con y sin servomotor. |
| [`2. Planos`](./2.%20Planos) | Planos técnicos (`.SLDDRW`) de las piezas y del ensamblaje general, más su versión en PDF. |
| [`3.Cinematica_Directa`](./3.Cinematica_Directa) | Desarrollo y cálculo de la cinemática directa del robot, resuelta por dos métodos independientes (Matrices de Transformación Homogénea y Denavit–Hartenberg) que se contrastan entre sí. |
| [`4.Cinematica_Inversa`](./4.Cinematica_Inversa) | Desarrollo y cálculo de la cinemática inversa del robot mediante desacoplamiento geométrico (ley de cosenos para $\theta_1,\theta_2$ y despeje directo para $d_3$). |
| `5. Matlab_Simscape` | Modelo y simulación del robot en Matlab/Simulink usando Simscape Multibody. |
| `6. Matlab_PeterCorke` | Modelado y simulación del robot usando el Robotics Toolbox de Peter Corke para Matlab. |
| `7. URDF` *(próximamente)* | Descripción del robot en formato URDF para su uso en distintos entornos. |

> 📌 Cada carpeta cuenta (o contará) con su propio `README.md` explicando en detalle su contenido.

## Estado del proyecto

- [x] Diseño CAD de piezas y ensamblajes
- [x] Planos técnicos
- [x] Cinemática directa
- [x] Cinemática inversa
- [ ] Simulación en Matlab (Simscape y Peter Corke)
- [ ] Descripción URDF (en desarrollo)

## Requisitos

- SolidWorks (para abrir y editar los archivos `.SLDPRT` / `.SLDASM` / `.SLDDRW`)
- Matlab con Simscape Multibody y el Robotics Toolbox de Peter Corke