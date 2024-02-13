from typing import Optional, Protocol
from back.src.domain.entities.image import Image


class IImageService(Protocol):
    def compress(self, image: Image) -> Optional[Image]:
        ...
    def get(self) -> str:
        ...