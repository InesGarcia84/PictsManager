from sqlalchemy import Column, Integer, ForeignKey, String
from sqlalchemy.orm import relationship

from infrastructure.db import Base

class Image(Base):
    __tablename__ = 'images'

    id = Column(Integer, primary_key=True, index=True)
    image = Column(String, unique=True)
    name = Column(String, index=True)
    size = Column(Integer, index=True)
    tags = Column(String, index=True, nullable=True)
    
    library_id = Column(Integer, ForeignKey('library.id'))
    library = relationship("Library", back_populates="images")