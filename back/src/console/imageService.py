from typing import Optional
from back.src.domain.entities.image import Image
from back.src.domain.inputs.iImageService import IImageService
from PIL import Image as imagePil

class ImageService(IImageService):
    def compress(self, image: Image) -> Optional[Image]:
        imagePil = Image.open(image.url)

        imagePil.save("image-file-compressed",
                    "JPEG",
                    optimize = True,
                    quality = 10)
        return
    
    def get(self) -> str:
        return "Hello, World!"