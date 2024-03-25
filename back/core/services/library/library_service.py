from adapters.library_repository import LibraryRepository
from adapters.user_repository import UserRepository
from infrastructure.db import get_db
from core.entities.library import Library
from sqlalchemy.orm import Session
from core.services.library.i_library_service import ILibraryService
from typing import List

class LibraryService(ILibraryService):
    def __init__(self):
        db : Session = next(get_db())
        self.library_repository = LibraryRepository(db)
        self.user_repository = UserRepository(db)

    def create_library(self, title: str, author: str, user_id: int):
        user = self.user_repository.get_user_by_id(user_id)
        lib = Library(title=title, author=author, users=[user])
        return self.library_repository.create_library(lib)

    def get_library_by_id(self, library_id: int):
        return self.library_repository.get_library_by_id(library_id)

    def get_all_libraries(self):
        return self.library_repository.get_all_libraries()

    def delete_library(self, library_id: int):
        return self.library_repository.delete_library(library_id)

    def get_libraries_by_user(self, user_id: int):
        return self.library_repository.get_libraries_by_user(user_id)
    
    def add_user_to_library(self, user_id: int, library_id: int):
        return self.library_repository.add_user_to_library(user_id, library_id)
    
    def search_library(self,string: str) -> List[Library]:
        return self.library_repository.search_library(string)
    
    def check_if_user_lib_exist(self, user_id: int, library_id: int):
        return self.library_repository.check_if_user_lib_exist(user_id,library_id)