from abc import ABC


class ILibraryRepository(ABC):
    
    def create_library(self, title: str, author: str, user_id: int):
        pass

    def get_library_by_id(self, library_id: int):
        pass

    def get_all_libraries(self):
        pass

    def delete_library(self, library_id: int):
        pass

    # def get_libraries_by_user(self, user):
    #     pass