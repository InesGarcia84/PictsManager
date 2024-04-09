from transformers import AutoImageProcessor, ResNetForImageClassification
from pydantic import BaseModel
from typing import Any
from io import BytesIO
import base64
from PIL import Image
import requests

class Model(ResNetForImageClassification):
  class Config:
    arbitrary_types_allowed = True

class Processor(AutoImageProcessor):
  class Config:
    arbitrary_types_allowed = True
    
class ImageClassifier(BaseModel):
  class Config:
     arbitrary_types_allowed = True
     
  modelName: str = 'Az-r-ow/resnet-50-cifar100-custom'
  model: Model = ResNetForImageClassification.from_pretrained(modelName)
  processor: Processor =  AutoImageProcessor.from_pretrained(modelName)
  
  def __init__(self):
    super().__init__()
  
  def classify(self, image: str) -> str:
    image = Image.open(requests.get(image, stream=True).raw).convert("RGB")
    image = image.resize((32, 32))
    inputs = self.processor(images=image, return_tensors="pt")
    outputs = self.model(**inputs)
    predictions = outputs.logits.argmax(-1).item()
    return self.model.config.id2label[predictions]