from fastapi import FastAPI
from fastapi.applications import AppType

from src.api.imageRouter.handler import image_router
from src.api.authRouter.handler import auth_router

def initServer(app: FastAPI) -> AppType:
    app.include_router(image_router)
    app.include_router(auth_router)
    
    return app