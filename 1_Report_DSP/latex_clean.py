import os
import sys

# List of LaTeX compilation file extensions to delete
latex_extensions = [
    ".aux", ".bbl", ".blg", ".dvi", ".fdb_latexmk", ".fls", ".log", ".nlo",
    ".out", ".synctex.gz", ".tdo", ".toc", ".glo", ".acn", ".ist"
]

# Main file name from the command line 
# (e.g. python latex_clean.py 2_main_dsp_sim[.tex]),
# otherwise ask for it
if len(sys.argv) > 1:
    main_name = sys.argv[1]
else:
    main_name = input("Name of the main tex file: ").strip()

main_stem = main_name[:-4] if main_name.endswith(".tex") else main_name
if not main_stem:
    sys.exit("No main file name given.")

base_dir = os.path.dirname(os.path.abspath(__file__))

# Only build files belonging to the chosen main file (e.g. <main>.aux, <main>.log)
for file in os.listdir(base_dir):
    file_path = os.path.join(base_dir, file)
    if not os.path.isfile(file_path):
        continue
    if any(file == main_stem + ext for ext in latex_extensions):
        try:
            os.remove(file_path)
            print(f"Deleted: {file_path}")
        except Exception as e:
            print(f"Error deleting {file_path}: {e}")
