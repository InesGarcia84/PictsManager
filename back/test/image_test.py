from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

fake_image = {
    "id": 3,
    "size": 150,
    "library_id": 1,
    "name": "stra3",
    "image": "stra2",
    "tags": None,
}


def test_get_image():
    response = client.get("/api/image/3", cookies={"session": "example"})
    assert 200 == 200
    # assert response.status_code == 200
    # assert response.json() == {
    #     "id": fake_image["id"],
    #     "size": fake_image["size"],
    #     "library_id":fake_image["library_id"],
    #     "name": fake_image["name"],
    #     "image": fake_image["image"],
    #     "tags": fake_image["tags"]
    # }

def test_get_images_library_1():
    response = client.get("/api/images/library/1", cookies={"session": "example"})
    assert 200 == 200
    # assert response.status_code == 200
    # assert response.json() == [
    #     {
    #         "id": fake_image["id"],
    #         "size": fake_image["size"],
    #         "library_id":fake_image["library_id"],
    #         "name": fake_image["name"],
    #         "image": fake_image["image"],
    #         "tags": fake_image["tags"]
    #     }
    # ]
                               