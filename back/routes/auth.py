import os
from fastapi.responses import RedirectResponse
from sqlalchemy.orm import Session
from dotenv import load_dotenv
from fastapi import APIRouter, Request, Response
from adapters.user_repository import UserRepository
from infrastructure.db import get_db
from core.services.user.user_service import UserService
from authlib.integrations.starlette_client import OAuth, OAuthError

auth_router = APIRouter(tags=["Auth"])

oauth = OAuth()

# Use a session from the session factory
db: Session = next(get_db())
user_repository = UserRepository(db)

user_service = UserService(user_repository)

load_dotenv()  # Loads environment variables from .env file
GOOGLE_CLIENT_ID = os.getenv("GOOGLE_CLIENT_ID")
GOOGLE_CLIENT_SECRET = os.getenv("GOOGLE_CLIENT_SECRET")
GOOGLE_REDIRECT_URI = os.getenv("GOOGLE_REDIRECT_URI")

oauth.register(
    name='google',
    server_metadata_url='https://accounts.google.com/.well-known/openid-configuration',
    client_id=GOOGLE_CLIENT_ID,
    client_secret=GOOGLE_CLIENT_SECRET,
    client_kwargs={
        'scope': 'email openid profile',
        'redirect_url': GOOGLE_REDIRECT_URI
    }
)

@auth_router.get("/")
def index(request: Request):
    user = request.session.get('user')
    if user:
        return Response(f'user: {user}')
    else:
        return RedirectResponse('/login')


@auth_router.get("/login")
async def login(request: Request):
    url = request.url_for('auth')
    return await oauth.google.authorize_redirect(request, url)

@auth_router.get('/auth')
async def auth(request: Request):
    try:
        token = await oauth.google.authorize_access_token(request)
    except OAuthError as e:
        print(e)
    user = token.get('userinfo')
    if user:
        request.session['user'] = dict(user)
    user_service.create_user(user)
    return Response(f'token: {token}')

@auth_router.get('/logout')
def logout(request: Request):
    request.session.pop('user')
    request.session.clear()
    return RedirectResponse('/')