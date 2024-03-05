from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


# Create a base class for your models
Base = declarative_base()

# Create a session factory
Session = sessionmaker()

engine = create_engine('postgresql://user:password@localhost/dbname')
Session.configure(bind=engine)

# Now you can create new Session instances using Session()
session = Session()