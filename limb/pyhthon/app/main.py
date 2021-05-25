# TODO split in different files and library for now it's a simple publisher
#  that takes a json payload
# TODO maybe use requests sessions
import json
import os
import argparse
import uuid
import google.oauth2.credentials as g_credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request, requests

# argument parsing
parser = argparse.ArgumentParser()
parser.add_argument("-t", "--title", required=True)
parser.add_argument("-m", "--message", required=True)
parser.add_argument("-c", "--color", default='inherit')
parser.add_argument("-u", "--uid", default=str(uuid.uuid4()))
args = parser.parse_args()

# SECTION directory init
config_path = os.getenv("AMBROGIO_HOME")
if not config_path:
    config_path = os.path.join(os.getenv("HOME", "~"), ".config", "ambrogio")

credentials_json = os.path.join(config_path, 'credentials.json')

if not os.path.isdir(config_path):
    os.makedirs(config_path)

# SECTION credentials init
if not os.path.isfile(credentials_json):
    scopes = [
        "openid",
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/firebase.database"
    ]
    flow = InstalledAppFlow.from_client_secrets_file("client_secret.json", scopes)
    flow.run_console()

    with open(credentials_json, 'w') as f:
        f.write(flow.credentials.to_json())

# SECTION access token obtain/refresh
credentials = g_credentials.Credentials.from_authorized_user_file(credentials_json)

# TODO method for refreshing
if not credentials.valid:
    credentials.refresh(Request())
    with open(credentials_json, 'w') as f:
        f.write(credentials.to_json())


# SECTION firebase token obtain
post_body = f"access_token={credentials.token}&providerId=google.com"
response = requests.post(
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=AIzaSyAyL6xjIrXuNfaVQ1HlBTTxR-BfewzZG28",
    data=json.dumps({"postBody": post_body, "requestUri": "http://localhost", "returnSecureToken": True,
                     "returnIdpCredential": True}))

assert response.status_code == 200

response_json = response.json()
firebase_uid = response_json["localId"]
firebase_token = response_json["idToken"]

# SECTION notification publishing

notification = {
    'title': args.title,
    'text': args.message,
    'color': args.color,
    'uid': args.uid
}

response = requests.put(
    f"https://ambrogio-hydra.firebaseio.com/{firebase_uid}/notifications/last-notification.json?auth={firebase_token}",
    data=json.dumps(notification))

print(response.text)
