# ports/user_repository.py
from abc import ABC, abstractmethod
from typing import List
from core.entities.image import Image

class IImageRepository(ABC):
    @abstractmethod
    def create_image(self, image: str, name: str, size: int) -> Image:
        pass

    @abstractmethod
    def get_image_by_id(self, image_id: int) -> Image:
        pass

    @abstractmethod
    def get_all_images(self) -> List[Image]:
        pass
    
    @abstractmethod
    def delete_image(self, image_id: int):
        pass


