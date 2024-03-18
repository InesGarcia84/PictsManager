from typing import List
from infrastructure.db import get_db
from sqlalchemy.orm import Session
from core.entities.library import Library
from core.entities.user_library import UserLibrary
from ports.i_library_repository import ILibraryRepository


class LibraryRepository(ILibraryRepository):
    def __init__(self, db = None):
        if db is None:
            db: Session = next(get_db())
        self.session = db

    def create_library(self, library: Library):
        try:
            self.session.add(library)
            self.session.commit()
        except:
            # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Close the session
            self.session.close()
        return library

    def add_user_to_library(self, user_id: int, library_id: int):
        userLibrary = UserLibrary(user_id=user_id, library_id=library_id)
        try:
            self.session.add(userLibrary)
            self.session.commit()
        except:
            # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Close the session
            self.session.close()
        return userLibrary
    
    def get_library_by_id(self, library_id: int):
        return self.session.query(Library).filter(Library.id == library_id).first()
    
    def get_all_libraries(self):
        return self.session.query(Library).all()
    
    def delete_library(self, library_id: int):
        library = self.session.query(Library).filter(Library.id == library_id).first()
        try:
            self.session.delete(library)
            self.session.commit()
        except:
            # Rollback the transaction in case of an exception
            self.session.rollback()
            raise
        finally:
            # Close the session
            self.session.close()
    
    def get_libraries_by_user(self, user_id: int):
        libraries = self.session.query(Library).join(UserLibrary).filter(UserLibrary.user_id == user_id).all()
        return libraries
    
    def search_library(self,string: str)-> List[Library]: 
        searched_items = self.session.query(Library).filter(Library.title.like(f"%{string}%")).all()
        return searched_items