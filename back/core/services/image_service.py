# core/image_service.py
from typing import List
from adapters.image.image_repository import ImageRepository
from core.services.i_image_service import IImageService
from core.entities.image import Image

class ImageService(IImageService):
    def __init__(self, image_repository: ImageRepository):
        self.image_repository = image_repository

    def create_image(self, image: str, name: str, size: int) -> Image:
        return self.image_repository.create_image(image, name, size)

    def get_image_by_id(self, image_id: int) -> Image:
        return self.image_repository.get_image_by_id(image_id)

    def get_all_images(self) -> List[Image]:
        return self.image_repository.get_all_images()
    
    def delete_image(self, image_id: int):
        return self.image_repository.delete_image(image_id)
