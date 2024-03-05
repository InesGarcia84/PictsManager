# main.py
from fastapi import FastAPI
# from routes.user import user_router
from routes.auth import auth_router
from routes.user import user_router
from routes.image import image_router

app = FastAPI()

# Include the user routes
app.include_router(auth_router)
app.include_router(user_router, prefix="/api")
app.include_router(image_router, prefix="/api")
