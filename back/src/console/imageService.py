import io
from typing import Optional
from PIL import Image as imagePil

from src.domain.entities.image import Image
from src.domain.inputs.iImageService import IImageService

class ImageService(IImageService):
    def compress(image: Image) -> Optional[Image]:
        img = imagePil.open(io.BytesIO(image.content))
        if img.mode in ("RGBA", "P"):
            img = img.convert("RGB")
        img.save(image.filename, optimize=True, quality=10)
        return Image(content=img, filename=image.filename)