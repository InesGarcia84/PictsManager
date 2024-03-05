from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import relationship
from infrastructure.db import Base

class Library(Base):
    __tablename__ = 'library'

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, index=True)
    author = Column(String, index=True)


    # Define the relationship with Image
    images = relationship("Image", back_populates="library")