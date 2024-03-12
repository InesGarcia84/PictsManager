# core/image_service.py
from typing import List
from adapters.image_repository import ImageRepository
from core.services.image.i_image_service import IImageService
from core.entities.image import Image

class ImageService(IImageService):
    def __init__(self, image_repository: ImageRepository):
        self.image_repository = image_repository

    def create_image(self, image: str, name: str, size: int, library_id: int) -> Image:
        return self.image_repository.create_image(image, name, size, library_id)

    def get_image_by_id(self, image_id: int) -> Image:
        return self.image_repository.get_image_by_id(image_id)

    def get_all_images(self, library_id) -> List[Image]:
        return self.image_repository.get_all_images(library_id)
    
    def delete_image(self, image_id: int):
        return self.image_repository.delete_image(image_id)

    def search_image(self,string: str) -> List[Image]:
        return self.image_repository.search_image(string)