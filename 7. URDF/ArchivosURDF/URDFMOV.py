import math
import os
import tempfile
import time

import pybullet as p

# Carpeta de este script (las rutas son relativas, funciona al clonar el repo)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
URDF_FILE = os.path.join(BASE_DIR, "urdf", "EnsamblajeFinal.SLDASM.urdf")
PREFIJO = "package://EnsamblajeFinal.SLDASM/"

H4 = 0.054  # m. Distancia del frame del link Cremallera a la punta (h4 = 5.40 cm)


def cargar_urdf_con_rutas_locales():
    """PyBullet no resuelve package://, asi que se crea una copia temporal
    del URDF con las rutas de las mallas apuntando a esta carpeta."""
    with open(URDF_FILE, encoding="utf-8") as f:
        texto = f.read()
    texto = texto.replace(PREFIJO, BASE_DIR.replace("\\", "/") + "/")
    tmp = os.path.join(tempfile.gettempdir(), "scara_tmp.urdf")
    with open(tmp, "w", encoding="utf-8") as f:
        f.write(texto)
    return tmp


# Conectar a PyBullet
p.connect(p.GUI)

# Cargar robot
robot = p.loadURDF(cargar_urdf_con_rutas_locales(), useFixedBase=True)

# Mostrar joints encontrados
print("=== JOINTS ===")
for i in range(p.getNumJoints(robot)):
    print(i, p.getJointInfo(robot, i)[1].decode())

# Sliders (JointP2 = theta1, JointP3 = theta2, JointCremallera = d3)
slider_p2 = p.addUserDebugParameter("JointP2 (theta1) [rad]", -math.pi, math.pi, 0)
slider_p3 = p.addUserDebugParameter("JointP3 (theta2) [rad]", -math.pi, math.pi, 0)
slider_c = p.addUserDebugParameter("JointCremallera (d3) [m]", 0.0, 0.054, 0)

try:
    while p.isConnected():
        # Leer sliders
        q1 = p.readUserDebugParameter(slider_p2)
        q2 = p.readUserDebugParameter(slider_p3)
        q3 = p.readUserDebugParameter(slider_c)

        # Actualizar joints
        p.resetJointState(robot, 0, q1)
        p.resetJointState(robot, 1, q2)
        p.resetJointState(robot, 2, q3)

        # Posicion del efector: origen del frame del link Cremallera (indice 4 y 5
        # de getLinkState; el indice 0 seria el centro de masa) + h4 a lo largo de su eje z.
        estado = p.getLinkState(robot, 2, computeForwardKinematics=True)
        pos, orn = estado[4], estado[5]
        R = p.getMatrixFromQuaternion(orn)
        x = pos[0] + R[2] * H4
        y = pos[1] + R[5] * H4
        z = pos[2] + R[8] * H4

        print(
            f"theta1={math.degrees(q1): 7.2f} deg | "
            f"theta2={math.degrees(q2): 7.2f} deg | "
            f"d3={q3 * 100: 5.2f} cm | "
            f"X={x * 100: 7.3f} cm | "
            f"Y={y * 100: 7.3f} cm | "
            f"Z={z * 100: 7.3f} cm",
            end="\r",
        )

        p.stepSimulation()
        time.sleep(1 / 240)

except KeyboardInterrupt:
    pass

finally:
    if p.isConnected():
        p.disconnect()
