# core/library_service.py
from abc import ABC, abstractmethod
from typing import List
from core.entities.user import User
from core.entities.library import Library

class ILibraryService(ABC):
    @abstractmethod
    def create_library(self, title: str, author: str, image_ids: List[int]) -> Library:
        pass

    @abstractmethod
    def get_library_by_id(self, library_id: int) -> Library:
        pass

    @abstractmethod
    def get_all_libraries(self) -> List[Library]:
        pass

    @abstractmethod
    def delete_library(self, library_id: int):
        pass
    
    # @abstractmethod
    # def get_libraries_by_user(self, user: User) -> List[Library]:
    #     pass

