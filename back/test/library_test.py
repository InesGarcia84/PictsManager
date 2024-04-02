from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

fake_library = {
    "title": "luia",
    "author": "moi",
    "id": 1
}

def test_get_library():
    response = client.get("/api/library/1", cookies={"session": "example"})
    assert response.status_code == 200
    assert response.json() == {
        "title": fake_library["title"],
        "author": fake_library["author"],
        "id": fake_library["id"]
    }

def test_get_libraries():
    response = client.get("/api/library", cookies={"session": "example"})
    assert response.status_code == 200
    assert response.json() == [
        {
            "title": fake_library["title"],
            "author": fake_library["author"],
            "id": fake_library["id"]
        }
    ]
                               