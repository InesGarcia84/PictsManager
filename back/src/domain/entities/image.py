from pydantic import BaseModel

class Image(BaseModel):
    id: int
    content: bytes
    name: str
    size: int