from pydantic import BaseModel

class Image(BaseModel):
    content: bytes
    filename: str