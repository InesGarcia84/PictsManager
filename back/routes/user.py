# # routes/users.py
# from fastapi import APIRouter, HTTPException
# from typing import List
# from core.entities.user import User
# from ports.user.i_user_repository import UserRepository

# user_router = APIRouter()

# @user_router.post("/user/", response_model=User)
# async def create_user(id:int ,username: str, email: str,picture: str, user_repository: UserRepository):
#     new_user = User(id=id, username=username, email=email, picture=picture)
#     created_user = user_repository.create_user(new_user)
#     return created_user

# @user_router.get("/user/{user_id}", response_model=User)
# async def read_user(user_id: int, user_repository: UserRepository):
#     user = user_repository.get_user_by_id(user_id)
#     if user is None:
#         raise HTTPException(status_code=404, detail="User not found")
#     return user

# @user_router.get("/user/", response_model=List[User])
# async def read_users(user_repository: UserRepository):
#     return user_repository.get_all_users()
