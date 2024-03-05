from core.entities.library import Library
from ports.i_library_repository import ILibraryRepository


class LibraryRepository(ILibraryRepository):
    def __init__(self, session):
        self.session = session

    def create_library(self, library: Library):
        self.session.add(library)
        self.session.commit()
        return library

    def get_library_by_id(self, library_id: int):
        return self.session.query(Library).filter(Library.id == library_id).first()
    
    def get_all_libraries(self):
        return self.session.query(Library).all()
    
    def delete_library(self, library_id: int):
        library = self.session.query(Library).filter(Library.id == library_id).first()
        self.session.delete(library)
        self.session.commit()
    
    # def get_libraries_by_user(self, id: int):
    #     return self.session.query(Library).filter(Library.author.id == id).all()