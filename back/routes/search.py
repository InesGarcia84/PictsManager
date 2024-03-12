import json
from fastapi import APIRouter
from adapters.library_repository import LibraryRepository
from adapters.image_repository import ImageRepository
from sqlalchemy.orm import Session
from adapters.user_repository import UserRepository
from core.services.library.library_service import LibraryService
from core.services.image.image_service import ImageService

from infrastructure.db import get_db

search_router = APIRouter()

# Db session
db: Session = next(get_db())
library_repository = LibraryRepository(db)
user_repository = UserRepository(db)
image_repository = ImageRepository(db)

library_service = LibraryService(library_repository, user_repository)
image_service = ImageService(image_repository)

@search_router.post("/search")
async def search(string: str):
    dict = {}
    dict["libs"] = library_service.search_library(string)
    dict["img"] = image_service.search_image(string)
    data = {
        "libraries": dict["libs"],
        "images": dict["img"]
    }

    return data