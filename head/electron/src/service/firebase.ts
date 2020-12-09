import firebase from 'firebase'

const config = {
  apiKey: 'AIzaSyC8sK81H4_NZXLi5t3A1llQEI2_uO1r9g4',
  authDomain: 'ambrogio-hydra.firebaseapp.com',
  databaseURL: 'https://ambrogio-hydra.firebaseio.com',
  projectId: 'ambrogio-hydra',
  storageBucket: 'ambrogio-hydra.appspot.com',
  messagingSenderId: '370597727411',
  appId: '1:370597727411:web:9d13e739f1fad49a16f4c6'
}

firebase.initializeApp(config)

const auth = firebase.auth()
const googleAuthProvider = firebase.auth.GoogleAuthProvider
// Get a reference to the database service
const database = firebase.database()

export { auth, database, config, googleAuthProvider }
