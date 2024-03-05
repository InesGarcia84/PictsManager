# adapters/user_repository_impl.py
from typing import List
from sqlalchemy.orm import Session
from core.entities.user import User
from ports.user.i_user_repository import IUserRepository

class UserRepository(IUserRepository):

    def __init__(self, session: Session):
        self.session = session

    def create_user(self, google_auth_id: str, username: str, email: str, picture: str) -> User:
        new_user = User(google_auth_id=google_auth_id, username=username, email=email, picture=picture)
        self.session.add(new_user)
        self.session.commit()
        return self.get_user_by_google_id(google_auth_id)
    
    def get_user_by_id(self, user_id: int) -> User:
        return self.session.query(User).filter(User.id == user_id).first()
    
    def get_all_users(self) -> List[User]:
        return self.session.query(User).all()
    
    def get_user_by_google_id(self, google_auth_id: str) -> User:
        return self.session.query(User).filter(User.google_auth_id == google_auth_id).first()

    def delete_user(self, user_id: int):
        user = self.session.query(User).filter(User.id == user_id).first()
        self.session.delete(user)
        self.session.commit()