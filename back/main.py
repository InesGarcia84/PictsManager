from fastapi import FastAPI

from src.api.server import initServer

app = FastAPI(title="FASTAPI",
              description="test",
              version="1.0.0")

initServer(app)