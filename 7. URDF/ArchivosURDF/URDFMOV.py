import pybullet as p
import time

# Conectar a PyBullet
p.connect(p.GUI)

# Cargar robot
robot = p.loadURDF(
    r"C:\Users\agust\Downloads\EnsamblajeFinal.SLDASM\EnsamblajeFinal_SLDASM.urdf",
    useFixedBase=True
)

# Mostrar joints encontrados
print("=== JOINTS ===")
for i in range(p.getNumJoints(robot)):
    print(i, p.getJointInfo(robot, i)[1].decode())

# Sliders
slider_p2 = p.addUserDebugParameter(
    "JointP2",
    -3.1416,
    3.1416,
    0
)

slider_p3 = p.addUserDebugParameter(
    "JointP3",
    -3.1416,
    3.1416,
    0
)

slider_c = p.addUserDebugParameter(
    "JointC",
    -0.10,
    0.10,
    0
)

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

        # Obtener posición del efector final
        estado = p.getLinkState(robot, 2)

        x, y, z = estado[0]

        # Mostrar posición en consola
        print(
            f"q1={q1: .3f} rad | "
            f"q2={q2: .3f} rad | "
            f"d={q3: .3f} m | "
            f"X={x: .3f} m | "
            f"Y={y: .3f} m | "
            f"Z={z: .3f} m",
            end="\r"
        )

        p.stepSimulation()
        time.sleep(1/240)

except KeyboardInterrupt:
    pass

finally:
    if p.isConnected():
        p.disconnect()