# routes/images.py
from fastapi import APIRouter, HTTPException
from sqlalchemy.orm import Session
from infrastructure.db import get_db
from core.services.image.image_service import ImageService
from adapters.image_repository import ImageRepository

image_router = APIRouter()

# Use a session from the session factory
db: Session = next(get_db())
image_repository = ImageRepository(db)

image_service = ImageService(image_repository)

@image_router.post("/image/")
async def create_image(image: str, name: str, size: int, library_id: int):
    return image_service.create_image(image, name, size, library_id)

@image_router.delete("/image/{image_id}")
async def delete_image(image_id: int):
    image_service.delete_image(image_id)
    

@image_router.get("/image/{image_id}")
async def read_image(image_id: int):
    image = image_service.get_image_by_id(image_id)
    if image is None:
        raise HTTPException(status_code=404, detail="Image not found")
    return image.__dict__

@image_router.get("/images/library/{library_id}")
async def read_images(library_id: int):
    return image_service.get_all_images(library_id)

@image_router.post("/image/search")
async def search_image(string: str):
    return image_service.search_image(string)