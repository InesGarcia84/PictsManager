# adapters/image_repository_impl.py
from typing import List

import requests
from sqlalchemy.orm import Session
from infrastructure.db import get_db
from core.entities.image import Image
from ports.i_image_repository import IImageRepository
from requests.auth import HTTPBasicAuth

class ImageRepository(IImageRepository):

    def __init__(self, db = None):
        if db is None:
            db: Session = next(get_db())
        self.session = db

    @staticmethod
    def upload_image_to_imagga(image_path):
        url = "https://api.imagga.com/v2/uploads"
        auth = HTTPBasicAuth('acc_4bcda14b97e3bee', '64d5509aba655c46d58963da0fe71f62')
        files = {'image': open(image_path, 'rb')}
        response = requests.post(url, auth=auth, files=files)
        print(response)
        if response.status_code == 200:
            return response.json()['result']['upload_id']
        else:
            raise Exception("Image upload failed")

    @staticmethod
    def get_tags_for_image(upload_id):
        url = f"https://api.imagga.com/v2/tags?image_upload_id={upload_id}&limit=5"
        auth = HTTPBasicAuth('acc_4bcda14b97e3bee', '64d5509aba655c46d58963da0fe71f62')
        response = requests.get(url, auth=auth)
        print(response)
        if response.status_code == 200:
            tags = response.json()['result']['tags']
            return [tag['tag']['en'] for tag in tags]
        else:
            raise Exception("Failed to get tags for image")
        

    def create_image(self, db: Session, image_path: str, name: str, size: int, library_id: int):
        # Upload the image to Imagga and get the upload_id
        upload_id = self.upload_image_to_imagga(image_path)
        # Get the tags for the uploaded image
        tags = self.get_tags_for_image(upload_id)
        # Assume tags are returned as a list of tuples (tag, confidence), and we only want the tag with the highest confidence
        most_confident_tag = tags[0][0] if tags else None  # Extract the tag name of the most confident tag
        
        # Create a new image instance, including the most confident tag
        new_image = Image(image=image_path, name=name, size=size, library_id=library_id, tags=most_confident_tag)
        
        # Now, proceed with adding the new image to the database as before
        try:
            self.session.add(new_image)
            self.session.commit()
        except:
            # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Consider if you really want to close the session here, as mentioned in the previous discussion
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
    
