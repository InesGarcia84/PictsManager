# routes/users.py
from fastapi import APIRouter, HTTPException
from core.services.user.user_service import UserService

user_router = APIRouter()

user_service = UserService()

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
