# core/user_service.py
from abc import ABC, abstractmethod
from typing import List
from core.entities.user import User

class IUserService(ABC):
    @abstractmethod
    def create_user(self, google_auth_id: str, username: str, email: str, picture: str) -> User:
        pass

    @abstractmethod
    def get_user_by_id(self, user_id: int) -> User:
        pass

    @abstractmethod
    def get_all_users(self) -> List[User]:
        pass

    @abstractmethod
    def get_user_by_google_id(self, google_auth_id: str) -> User:
        pass

    @abstractmethod
    def delete_user(self, user_id: int):
        pass
