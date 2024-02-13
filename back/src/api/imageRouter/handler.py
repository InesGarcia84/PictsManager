from fastapi import APIRouter, FastAPI

from src.domain.entities.image import Image


app = FastAPI()
image_router = APIRouter(prefix="/image", tags=["Image"])

@image_router.post("/compress")
async def compress(image: Image):
    return image

@image_router.get("")
async def hello():
    return "Hello, World!"