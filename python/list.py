

    filtered_user = filter(lambda user: user["username"] == username, content)
    user = next(filtered_user)
