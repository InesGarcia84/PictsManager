# adapters/image_repository_impl.py
from typing import List
from sqlalchemy.orm import Session
from infrastructure.db import get_db
from core.entities.image import Image
from ports.i_image_repository import IImageRepository

class ImageRepository(IImageRepository):

    def __init__(self):
        db: Session = next(get_db())
        self.session = db

    def create_image(self, image: str, name: str, size: int, library_id) -> Image:
        new_image = Image(image=image, name=name, size=size, library_id=library_id)
        try:
            with self.session.begin():
                self.session.add(new_image)
                self.session.commit()
        except:
            # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Close the session
            self.session.close()
        return new_image
    
    def get_image_by_id(self, image_id: int) -> Image:
        return self.session.query(Image).filter(Image.id == image_id).first()
    
    def get_all_images(self, library_id: int) -> List[Image]:
        library_images = self.session.query(Image).filter_by(library_id=library_id).all()
        return library_images
    
    def delete_image(self, image_id: int):
        image = self.get_image_by_id(image_id)
        try:
            with self.session.begin():
                self.session.delete(image)
                self.session.commit()
        except:
        # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Close the session
            self.session.close()

    def search_image(self,string: str)-> List[Image]: 
        searched_items = self.session.query(Image).filter(Image.name.like(f"%{string}%")).all()
        return searched_items
    
