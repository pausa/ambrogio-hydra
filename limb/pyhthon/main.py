# TODO split in different files and library for now it's a simple publisher
#  that takes a json payload
# TODO better folder management
# TODO maybe use requests sessions
import json
import os.path

from google_auth_oauthlib.flow import InstalledAppFlow
from google.auth.transport.requests import Request, requests
import google.oauth2.credentials
import google.oauth2.id_token
from requests import Response

if not os.path.isfile('credentials.json'):
    scopes = [
        "openid",
        "https://www.googleapis.com/auth/userinfo.email",
        "https://www.googleapis.com/auth/firebase.database"
    ]
    flow = InstalledAppFlow.from_client_secrets_file("client_secret.json", scopes)
    flow.run_console()

    with open('credentials.json', 'w') as f:
        f.write(flow.credentials.to_json())

credentials = google.oauth2.credentials.Credentials.from_authorized_user_file('credentials.json')

# TODO method for refreshing
if not credentials.valid:
    credentials.refresh(Request())
    with open('credentials.json', 'w') as f:
        f.write(credentials.to_json())

post_body = "access_token={}&providerId=google.com".format(credentials.token)
response = requests.post(
    "https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=AIzaSyAyL6xjIrXuNfaVQ1HlBTTxR-BfewzZG28",
    data=json.dumps({"postBody": post_body, "requestUri": "http://localhost", "returnSecureToken": True,
                     "returnIdpCredential": True}))

assert response.status_code == 200

response_json = response.json()
firebase_uid = response_json["localId"]
firebase_token = response_json["idToken"]

notification = {
    'title': 'hello there!',
    'text': 'general kenobi...',
    'color': 'red',
    'uid': 3
}

response = requests.put(
    "https://ambrogio-hydra.firebaseio.com/{}/notifications/last-notification.json?auth={}".format(firebase_uid,
                                                                                                   firebase_token),
    data=json.dumps(notification))

print(response.text)
