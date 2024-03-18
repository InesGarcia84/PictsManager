from fastapi import APIRouter
from core.services.library.library_service import LibraryService

library_router = APIRouter()

library_service = LibraryService()

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
async def get_libraries_by_user(id: int):
    return library_service.get_libraries_by_user(id)

@library_router.post("/library/user/{user_id}/add/{library_id}")
async def add_user_to_library(user_id: int, library_id: int):
    return library_service.add_user_to_library(user_id, library_id)

@library_router.post("/library/search")
async def search_library(string: str):
    return library_service.search_library(string)