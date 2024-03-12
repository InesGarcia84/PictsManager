from adapters.library_repository import LibraryRepository
from adapters.user_repository import UserRepository
from core.entities.library import Library
from core.services.library.i_library_service import ILibraryService
from typing import List

class LibraryService(ILibraryService):
    def __init__(self, library_repository: LibraryRepository, user_repository: UserRepository):
        self.library_repository = library_repository
        self.user_repository = user_repository

    def create_library(self, title: str, author: str, user_id: int):
        users = self.user_repository.get_user_by_id(user_id)
        lib = Library(title=title, author=author, users=[users])
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