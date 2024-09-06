def is_valid_user(username, password):
    if username == "admin" and password == "admin":
        return True
    else:
        return False

def authenticate_user(username, password):
    DELETE_THIS_LINE_AND_PLACE_CURSOR_HERE