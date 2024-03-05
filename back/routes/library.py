
from fastapi import APIRouter
from adapters.library_repository import LibraryRepository
from sqlalchemy.orm import Session
from adapters.user_repository import UserRepository
from core.services.library.library_service import LibraryService
from infrastructure.db import get_db


library_router = APIRouter()

# Db session
db: Session = next(get_db())
library_repository = LibraryRepository(db)
user_repository = UserRepository(db)
library_service = LibraryService(library_repository, user_repository)



@library_router.get("/library")
async def get_all_libraries():
    return library_service.get_all_libraries()

@library_router.get("/library/{library_id}")
async def get_library_by_id(library_id: int):
    return library_service.get_library_by_id(library_id)

@library_router.post("/library")
async def create_library(title: str, author: str, user_id: int):
    return library_service.create_library(title, author, user_id)

@library_router.delete("/library/{library_id}")
async def delete_library(library_id: int):
    return library_service.delete_library(library_id)

@library_router.get("/library/user/{id}")
async def get_libraries_by_user(user_id: int):
    return library_service.get_libraries_by_user(user_id)

@library_router.post("/library/user/{user_id}/add/{library_id}")
async def add_user_to_library(user_id: int, library_id: int):
    return library_service.add_user_to_library(user_id, library_id)