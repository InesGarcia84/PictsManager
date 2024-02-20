from typing import Optional, Protocol

from src.domain.entities.image import Image


class IImageService(Protocol):
    def compress(image: Image) -> Optional[Image]:
        ...