from adapters.library_repository import LibraryRepository
from core.entities.library import Library
from core.services.library.i_library_service import ILibraryService

class LibraryService(ILibraryService):
    def __init__(self, library_repository: LibraryRepository):
        self.library_repository = library_repository

    def create_library(self, title: str, author: str):
        lib = Library(title=title, author=author)
        return self.library_repository.create_library(lib)

    def get_library_by_id(self, library_id: int):
        return self.library_repository.get_library_by_id(library_id)

    def get_all_libraries(self):
        return self.library_repository.get_all_libraries()

    def delete_library(self, library_id: int):
        return self.library_repository.delete_library(library_id)

    # def get_libraries_by_user(self, id: int):
    #     return self.library_repository.get_libraries_by_user(id)
