import secrets
import string

def generate_password(length=27):
    alphabet = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(secrets.choice(alphabet) for i in range(length))
    return password

# Example usage:
generated_password = generate_password()
print(generated_password)
