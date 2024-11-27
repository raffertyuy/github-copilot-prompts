def IsValidUser(username, password):
    if username == "admin" and password == "admin":
        return True
    else:
        return False

def Check(x, y):
    if IsValidUser(x, y):
        return "User authenticated"
    else:
        return "User not authenticated"