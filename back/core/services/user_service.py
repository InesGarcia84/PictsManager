# core/user_service.py
from typing import List
from adapters.user.user_repository import UserRepository
from core.services.i_user_service import IUserService
from core.entities.user import User

class UserService(IUserService):
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository

    def create_user(self, google_auth_id: str, username: str, email: str, picture: str) -> User:
        return self.user_repository.create_user(google_auth_id, username, email, picture)

    def get_user_by_id(self, user_id: int) -> User:
        return self.user_repository.get_user_by_id(user_id)

    def get_all_users(self) -> List[User]:
        return self.user_repository.get_all_users()
