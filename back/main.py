# main.py
from fastapi import Depends, FastAPI, HTTPException, Request
from starlette.middleware.sessions import SessionMiddleware
from routes.auth import auth_router
from routes.user import user_router
from routes.image import image_router
from routes.library import library_router

app = FastAPI()
app.add_middleware(SessionMiddleware, secret_key="!secret")


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

