from transformers import BeitImageProcessor, BeitForImageClassification
from pydantic import BaseModel
from io import BytesIO
import base64
from PIL import Image

class ImageClassifier(BaseModel):
  modelName: str = 'microsoft/beit-base-patch16-224-pt22k-ft22k'
  model = None
  processor = None
  
  def __init__(self, **data):
    super().__init__(**data)
    if not self.model:
        self.model = BeitForImageClassification.from_pretrained(self.modelName)
    if not self.processor:
        self.processor = BeitImageProcessor.from_pretrained(self.modelName)
    
  def classify(self, image: str) -> str:
    image = Image.open(BytesIO(base64.b64decode(image)))
    inputs = self.processor(image=image, return_tensors="pt")
    outputs = self.model(**inputs)
    predictions = outputs.logits.argmax(-1).item()
    return self.model.config.id2label[predictions]