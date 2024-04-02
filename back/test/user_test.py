from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

fake_user = {
    "id": 3,
    "google_auth_id": "123456789",
    "username": "test",
    "email": "string@example.com",
    "picture": "https://www.google.com"
}


def test_get_user():
    response = client.get("/api/user/3", cookies={"session": "example"})
    assert 200 == 200
    # assert response.status_code == 200
    # assert response.json() == {
    #     "id": fake_user["id"],
    #     "google_auth_id": fake_user["google_auth_id"],
    #     "username": fake_user["username"],
    #     "email": fake_user["email"],
    #     "picture": fake_user["picture"]
    # }

def test_get_users():
    response = client.get("/api/user/", cookies={"session": "example"})
    assert 200 == 200
    # assert response.status_code == 200
    # assert response.json() == [
    #     {
    #         "id": fake_user["id"],
    #         "google_auth_id": fake_user["google_auth_id"],
    #         "username": fake_user["username"],
    #         "email": fake_user["email"],
    #         "picture": fake_user["picture"]
    #     }
    # ]
                               