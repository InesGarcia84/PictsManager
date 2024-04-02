from pydantic import BaseModel


class ImageSchema(BaseModel):
    image: str
    name: str
    size: int
    library_id: int