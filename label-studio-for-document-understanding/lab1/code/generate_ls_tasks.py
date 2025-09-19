import os
import json
from pathlib import Path
from pdf2image import convert_from_path

def pdf_to_images(pdf_path, output_folder):
    
    # Converts a PDF to images and saves them in a folder named after the PDF inside output_folder.

    pdf_name = pdf_path.stem
    save_folder = output_folder / pdf_name
    save_folder.mkdir(parents=True, exist_ok=True)

    # Skip conversion if images already exist
    if any(save_folder.iterdir()):
        return save_folder

    pages = convert_from_path(str(pdf_path), dpi=300)
    for idx, page in enumerate(pages):
        image_path = save_folder / f"page_{idx + 1}.png"
        page.save(str(image_path), 'PNG')

    return save_folder

def generate_label_studio_tasks_json(ls_document_root, input_root, output_json, prefix="/data/local-files/?d="):
    
    # Scans input_root for PDFs and images, converts PDFs to images in output_images with the same structure,
    # and creates a Label Studio JSON.

    # Args:
        # ls_document_root (str): Label Studio document root. Same as LABEL_STUDIO_LOCAL_FILES_DOCUMENT_ROOT env variable.
        # input_root (str): Root directory containing PDFs and images.
        # output_json (str): Path to save the generated JSON.
        # prefix (str): Prefix to replace the local root path for Label Studio.

    # Returns:
        # int: Number of tasks created.

    input_root = Path(input_root)
    output_root = input_root.parent / "output_images"
    output_root = input_root.parent / f"Images_{input_root.name}"
    output_root.mkdir(parents=True, exist_ok=True)

    ls_document_root = Path(ls_document_root)
    tasks = []
    
    for root, _, files in os.walk(input_root):
        root_path = Path(root)
    
        for file in sorted(files):
            document_path = root_path / file
            file_lower = file.lower()
            if file_lower.endswith('.pdf'):
                relative_folder = root_path.relative_to(input_root)
                output_folder = output_root / relative_folder
                output_folder.mkdir(parents=True, exist_ok=True)

                # Convert PDF to images
                image_folder = pdf_to_images(document_path, output_folder)

                # Build base URL for Label Studio
                base_task_url = f"{prefix}{image_folder.relative_to(ls_document_root)}"
                pdf_label_studio_path = f"{prefix}{document_path.relative_to(ls_document_root)}"

                task = {
                    "data": {
                        "document": pdf_label_studio_path,
                        "pages": [],
                        "ls_document_root": str(ls_document_root)
                    }
                }

                images = sorted(image_folder.iterdir())
                for img in images:
                    page_entry = {
                        "page": f"{base_task_url}/{img.name}"
                    }
                    task["data"]["pages"].append(page_entry)

                tasks.append(task)

            elif file_lower.endswith(('.png', '.jpg', '.jpeg', '.tiff', '.bmp', '.gif')):
                image_label_studio_path = f"{prefix}{document_path.relative_to(ls_document_root)}"

                task = {
                    "data": {
                        "document": image_label_studio_path,
                        "pages": [{
                            "page": image_label_studio_path
                        }],
                        "ls_document_root": str(ls_document_root)
                    }
                }
                tasks.append(task)

    # Save JSON
    with open(output_json, "w") as f:
        json.dump(tasks, f, indent=2)

    print(f"JSON created with {len(tasks)} entries and saved to {output_json}")
    return len(tasks)

## Sample Example
generate_label_studio_tasks_json(
    ls_document_root="/home/raraushk/LS_integration/label_studio/datasets",
    input_root="/home/raraushk/LS_integration/label_studio/datasets/multi_folder",
    output_json="kv_tasks.json"
)