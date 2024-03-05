# models.py
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from infrastructure.db import Base

class User(Base):
    __tablename__ = 'users'

    id = Column(Integer, primary_key=True, index=True)
    google_auth_id = Column(String, unique=True, index=True)
    username = Column(String, index=True)
    email = Column(String, unique=True, index=True)
    picture = Column(String)  # Assuming the picture is stored as a URL

    libraries = relationship(
        "Library",
        secondary="user_library",
        back_populates="users",
    )