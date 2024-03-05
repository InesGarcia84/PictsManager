# routes/users.py
from fastapi import APIRouter, HTTPException

from sqlalchemy.orm import Session
from infrastructure.db import get_db
from core.services.user_service import UserService
from adapters.user.user_repository import UserRepository

user_router = APIRouter()

# Use a session from the session factory
db: Session = next(get_db())
user_repository = UserRepository(db)

user_service = UserService(user_repository)

@user_router.delete("/user/{user_id}")
async def delete_user(user_id: int):
    user_service.delete_user(user_id)
    

@user_router.get("/user/{user_id}")
async def read_user(user_id: int):
    user = user_service.get_user_by_id(user_id)
    if user is None:
        raise HTTPException(status_code=404, detail="User not found")
    return user.__dict__

@user_router.get("/user/")
async def read_users():
    return user_service.get_all_users()
