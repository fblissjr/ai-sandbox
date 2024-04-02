import os
import time
from moondream import Moondream, detect_device, LATEST_REVISION
from transformers import AutoTokenizer
from PIL import Image

device, dtype = detect_device()
model_id = "vikhyatk/moondream2"
revision = "2024-03-13"  # note there's a 3/6 revision running on the space
tokenizer = AutoTokenizer.from_pretrained(model_id, revision=LATEST_REVISION)
moondream = Moondream.from_pretrained(
    model_id,
    revision=LATEST_REVISION,
    trust_remote_code=True,
    torch_dtype=dtype,
).to(device=device)
moondream.eval()

# Get the list of image filenames in the ./images folder
image_folder = "./images"
image_filenames = [
    f
    for f in os.listdir(image_folder)
    if f.endswith((".jpg", ".jpeg", ".png", ".webp"))
]

prompts = [
    "Describe the vibe of this image, the items in this image in detail. Describe styles, materials, item types in this image.",
    "Describe the insanity of this image.",
    "Make this a funny image caption.",
]

# Create a list of tuples (image_filename, prompts) representing the cartesian product
image_prompt_pairs = [(image_filename, prompts) for image_filename in image_filenames]

# Process each image-prompt pair
for image_filename, prompts in image_prompt_pairs:
    image_path = os.path.join(image_folder, image_filename)
    image = Image.open(image_path)

    print(f"Starting inference for image: {image_filename}")
    start_time = time.time()

    answers = moondream.batch_answer(
        images=[image] * len(prompts),
        prompts=prompts,
        tokenizer=tokenizer,
    )

    end_time = time.time()
    elapsed_time = end_time - start_time
    elapsed_time_ms = int(elapsed_time * 1000)
    print(f"Inference completed for image: {image_filename}")
    print(f"Elapsed time: {elapsed_time:.2f} seconds ({elapsed_time_ms} ms)")
    print()

    for prompt, answer in zip(prompts, answers):
        print(f"Image: {image_filename}")
        print(f"Q: {prompt}")
        print(f"A: {answer}")
        print()
