from fastapi import APIRouter
from core.services.library.library_service import LibraryService
from core.services.image.image_service import ImageService

search_router = APIRouter()


library_service = LibraryService()
image_service = ImageService()

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