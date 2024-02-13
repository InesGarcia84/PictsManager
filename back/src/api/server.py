from fastapi import FastAPI
from fastapi.applications import AppType

from src.api.imageRouter.handler import image_router

def initServer(app: FastAPI) -> AppType:
    app.include_router(image_router)
    return app