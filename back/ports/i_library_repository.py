from abc import ABC, abstractmethod
from typing import List
from core.entities.library import Library


class ILibraryRepository(ABC):
    @abstractmethod
    def create_library(self, title: str, author: str, user_id: int):
        pass
    
    @abstractmethod
    def get_library_by_id(self, library_id: int):
        pass
    
    @abstractmethod
    def get_all_libraries(self):
        pass
    
    @abstractmethod
    def delete_library(self, library_id: int):
        pass
    
    @abstractmethod
    def get_libraries_by_user(self, user_id: int):
        pass

    @abstractmethod
    def add_user_to_library(self, user_id: int, library_id: int):
        pass

    @abstractmethod
    def search_library(self,string: str) -> List[Library]:
        pass
