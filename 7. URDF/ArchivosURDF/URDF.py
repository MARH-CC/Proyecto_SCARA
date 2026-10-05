import os
import yourdfpy

BASE_DIR = r"C:\Users\agust\Downloads\EnsamblajeFinal.SLDASM"

URDF_FILE = os.path.join(
    BASE_DIR,
    "EnsamblajeFinal_SLDASM.urdf"
)

def resolver_ruta(fname):

    print("Buscando:", fname)

    if fname.startswith("package://EnsamblajeFinal.SLDASM/"):
        fname = fname.replace(
            "package://EnsamblajeFinal.SLDASM/",
            ""
        )

    ruta_final = os.path.join(BASE_DIR, fname)

    print("Ruta final:", ruta_final)

    return ruta_final

robot = yourdfpy.URDF.load(
    URDF_FILE,
    filename_handler=resolver_ruta
)

print("\n=== LINKS ===")
for name in robot.link_map:
    print(name)

print("\n=== JOINTS ===")
for name, joint in robot.joint_map.items():
    print(
        f"{name}: {joint.type} | eje={joint.axis}"
    )

robot.show()