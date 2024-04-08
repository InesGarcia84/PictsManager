# from transformers import BeitImageProcessor, BeitForImageClassification
from transformers import ViTImageProcessor, ViTForImageClassification
from pydantic import BaseModel
from typing import Any
from io import BytesIO
import base64
from PIL import Image
import requests

class Model(ViTForImageClassification):
  class Config:
    arbitrary_types_allowed = True

class Processor(ViTImageProcessor):
  class Config:
    arbitrary_types_allowed = True
    
class ImageClassifier(BaseModel):
  class Config:
     arbitrary_types_allowed = True
     
  modelName: str = 'google/vit-base-patch16-224'
  model: Model = ViTForImageClassification.from_pretrained(modelName)
  processor: Processor =  ViTImageProcessor.from_pretrained(modelName)
  
  def __init__(self):
    super().__init__()
  
  def classify(self, image: str) -> str:
    image = Image.open(requests.get(image, stream=True).raw)
    inputs = self.processor(images=image, return_tensors="pt")
    outputs = self.model(**inputs)
    predictions = outputs.logits.argmax(-1).item()
    labels = [self.model.config.id2label[i] for i in outputs.logits.argmax(-1).tolist()]
    return self.model.config.id2label[predictions]