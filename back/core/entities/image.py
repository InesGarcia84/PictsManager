# models.py
from sqlalchemy import Column, Integer, String, LargeBinary
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()

class Image(Base):
    __tablename__ = 'images'

    id = Column(Integer, primary_key=True, index=True)
    image = Column(String, unique=True)
    name = Column(String, index=True)
    size = Column(Integer, index=True)
    tags = Column(String, index=True,nullable=True)
