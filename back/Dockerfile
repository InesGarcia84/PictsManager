# Use the official Python base image
FROM python:3.9-slim

# Set the working directory inside the container
WORKDIR /PictManager

# Copy the application code to the working directory
COPY ./back /PictManager/

# Install the Python dependencies
RUN pip install -r /PictManager/requirements.txt

# Command used to start the app using Uvicorn
# CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]