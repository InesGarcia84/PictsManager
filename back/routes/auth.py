import json
import os
from sqlalchemy.orm import Session
from dotenv import load_dotenv
from fastapi import APIRouter, Depends
from fastapi.security import OAuth2PasswordBearer
import requests
from jose import jwt
from adapters.user.user_repository import UserRepository
from infrastructure.db import get_db
from core.services.user_service import UserService


auth_router = APIRouter(tags=["Auth"])
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Use a session from the session factory
db: Session = next(get_db())
user_repository = UserRepository(db)

user_service = UserService(user_repository)

load_dotenv()  # Loads environment variables from .env file
GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
GOOGLE_CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
GOOGLE_REDIRECT_URI = os.getenv("GOOGLE_REDIRECT_URI")

@auth_router.get("/login")
async def login_google():
    return {
        "url": f"https://accounts.google.com/o/oauth2/auth?response_type=code&client_id={GOOGLE_CLIENT_ID}&redirect_uri={GOOGLE_REDIRECT_URI}&scope=openid%20profile%20email&access_type=offline"
    }

@auth_router.get("/auth")
async def auth_google(code: str):
    token_url = "https://accounts.google.com/o/oauth2/token"
    data = {
        "code": code,
        "client_id": GOOGLE_CLIENT_ID,
        "client_secret": GOOGLE_CLIENT_SECRET,
        "redirect_uri": GOOGLE_REDIRECT_URI,
        "grant_type": "authorization_code",
    }
    response = requests.post(token_url, data=data)
    access_token = response.json().get("access_token")
    user_info = requests.get("https://www.googleapis.com/oauth2/v1/userinfo", headers={"Authorization": f"Bearer {access_token}"})

    user = json.loads(user_info.text)
    
    user_service.create_user(google_auth_id=user["id"], username=user["name"], email=user["email"], picture=user["picture"])

    return user_info

@auth_router.get("/token")
async def get_token(token: str = Depends(oauth2_scheme)):
    return jwt.decode(token, GOOGLE_CLIENT_SECRET, algorithms=["HS256"])()