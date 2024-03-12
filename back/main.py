# main.py
import os
from dotenv import load_dotenv
from fastapi import Depends, FastAPI, HTTPException, Request
from starlette.middleware.sessions import SessionMiddleware
from routes.auth import auth_router
from routes.user import user_router
from routes.image import image_router
from routes.library import library_router
from routes.search import search_router
app = FastAPI()
load_dotenv()
SECRET_KEY = os.getenv("SECRET_KEY")
app.add_middleware(SessionMiddleware, secret_key=SECRET_KEY)


async def check_auth_user(request: Request):
    if 'user' in request.session:   
        return request.session['user']
    else:
        raise HTTPException(status_code=401, detail="Unauthorized")
# Include the user routes
app.include_router(auth_router)
app.include_router(user_router, prefix="/api", dependencies=[Depends(check_auth_user)])
app.include_router(library_router, prefix="/api", dependencies=[Depends(check_auth_user)])
app.include_router(image_router, prefix="/api", dependencies=[Depends(check_auth_user)])
app.include_router(search_router,prefix="/api", dependencies=[Depends(check_auth_user)])
