
from sqlalchemy import Column, ForeignKey, Integer
from infrastructure.db import Base


class UserLibrary(Base):
    __tablename__ = 'user_library'

    user_id = Column(Integer, ForeignKey('users.id'), primary_key=True)
    library_id = Column(Integer, ForeignKey('library.id'), primary_key=True)