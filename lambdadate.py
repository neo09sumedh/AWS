import os
from datetime import date

def handler(event, context):
    DB_HOST = os.environ["DB_HOST"]
    DB_USER = os.environ["DB_USER"]
    DB_PASS = os.environ["DB_PASS"]
    today = date.today()
    print("Connected to %s as %s" % (DB_HOST, DB_USER))
    print("Today's date:", today)
    return None
