import os
from fastapi.responses import RedirectResponse
from dotenv import load_dotenv
from fastapi import APIRouter, Request, Response
from core.services.user.user_service import UserService
from authlib.integrations.starlette_client import OAuth, OAuthError

auth_router = APIRouter(tags=["Auth"])

oauth = OAuth()
user_service = UserService()

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


@auth_router.post("/login")
async def login(request: Request, token_id: str, google_id: str, email: str, name: str, picture: str):
    user = user_service.create_user(google_id,name, email, picture)
    request.session['user'] = {'id': user.id, 'google_auth': user.google_auth_id,'email':user.email, 'username': user.username, 'picture': user.picture}
    request.cookies['session'] = token_id
    user_response = request.session.get('user')
    return Response(f'user: {user_response}') 

@auth_router.get('/logout')
def logout(request: Request):
    request.session.pop('user')
    request.session.clear()
    return RedirectResponse('/')