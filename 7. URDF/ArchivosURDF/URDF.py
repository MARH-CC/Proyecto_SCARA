import os
import yourdfpy

# Carpeta de este script (las rutas son relativas, funciona al clonar el repo)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
URDF_FILE = os.path.join(BASE_DIR, "urdf", "EnsamblajeFinal.SLDASM.urdf")
PREFIJO = "package://EnsamblajeFinal.SLDASM/"


def resolver_ruta(fname):
    """Convierte package://EnsamblajeFinal.SLDASM/meshes/X.STL en una ruta local."""
    if fname.startswith(PREFIJO):
        fname = fname.replace(PREFIJO, "")
    return os.path.join(BASE_DIR, fname)


robot = yourdfpy.URDF.load(URDF_FILE, filename_handler=resolver_ruta)

print("\n=== LINKS ===")
for name in robot.link_map:
    print(name)

print("\n=== JOINTS ===")
for name, joint in robot.joint_map.items():
    print(f"{name}: {joint.type} | eje={joint.axis} | origen={joint.origin[:3, 3]}")

robot.show()
