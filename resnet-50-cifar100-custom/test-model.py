from transformers import AutoImageProcessor, ResNetForImageClassification
from PIL import Image
import os 

model_path = "./resnet-50-cifar100-custom-beans"

processor = AutoImageProcessor.from_pretrained(model_path)
model = ResNetForImageClassification.from_pretrained(model_path)

# Load images from dataset folder
image_folder = "datasets"
images_dir = os.listdir(image_folder)
if '.DS_Store' in images_dir:
  images_dir.remove('.DS_Store')
  
image_paths = ["{}/{}".format(image_folder, filename) for filename in images_dir]

for image_path in image_paths:
  image = Image.open(image_path).convert("RGB")
  
  image = image.resize((32, 32))
  
  inputs = processor(image, return_tensors="pt")
  
  logits = model(**inputs).logits
  
  predicted_label = logits.argmax(-1).item()
  print(f"{image_path} => {model.config.id2label[predicted_label]}")