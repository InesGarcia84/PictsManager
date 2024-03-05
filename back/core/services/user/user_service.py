# core/user_service.py
import json
from typing import List
from adapters.user_repository import UserRepository
from core.services.user.i_user_service import IUserService
from core.entities.user import User

class UserService(IUserService):
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository

    def create_user(self, user_info: str) -> User:

        user = json.loads(user_info.text)
        google_auth_id=user["id"]
        username=user["name"]
        email=user["email"]
        picture=user["picture"]

        # Check if user already exist

        if self.get_user_by_google_id(google_auth_id) is None:
            user = self.user_repository.create_user(google_auth_id, username, email, picture)
        else:
            user = self.get_user_by_google_id(google_auth_id)

        return user


    def get_user_by_google_id(self, google_auth_id) -> User:
        return self.user_repository.get_user_by_google_id(google_auth_id)

    def get_user_by_id(self, user_id: int) -> User:
        return self.user_repository.get_user_by_id(user_id)

    def get_all_users(self) -> List[User]:
        return self.user_repository.get_all_users()

    def delete_user(self, user_id: int):
        return self.user_repository.delete_user(user_id)