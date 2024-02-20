import uuid
from fastapi import APIRouter, FastAPI, File, UploadFile,Request, status
from src.console.imageService import ImageService
from fastapi.responses import JSONResponse
from fastapi.exceptions import RequestValidationError
from src.domain.entities.image import Image


app = FastAPI()
image_router = APIRouter(prefix="/image", tags=["Image"])

@image_router.post("/compress")
async def compress(file : UploadFile = File(...)):
    file.filename = f"{uuid.uuid4()}.jpg"
    content = await file.read()
    img = Image(content=content, filename=file.filename)
    img = ImageService.compress(image=img)
    return img
    

@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content={"detail": exc.errors()},
    )