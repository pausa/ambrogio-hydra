import { ipcRenderer } from 'electron'
import { auth, config as firebaseConfig, database } from '@/service/firebase'
import {
  START_NOTIFICATION_SERVICE,
  NOTIFICATION_SERVICE_STARTED,
  NOTIFICATION_SERVICE_ERROR,
  NOTIFICATION_RECEIVED as ON_NOTIFICATION_RECEIVED,
  TOKEN_UPDATED
} from 'electron-push-receiver'

class CloudMessaging {
  // TODO make it singleton?
  constructor () {
    auth.onAuthStateChanged((user) => {
      if (user) {
        // notification should be init only after registered to firebase
        // TODO make singleton or deregister
        this.initListeners()
      }
    })
  }

  initListeners () {
    console.log('intializing cloud messaging')
    // TODO better error handling
    ipcRenderer.on(NOTIFICATION_SERVICE_ERROR, (_, error) =>
      console.error(`Error in notification service: ${error}`))

    ipcRenderer.on(NOTIFICATION_SERVICE_STARTED, (_, token) => {
      console.log('Notification service started')
      this.updateToken(token)
    })

    ipcRenderer.on(TOKEN_UPDATED, (_, token) => {
      console.log('Token was updated')
      this.updateToken(token)
    })

    ipcRenderer.send(START_NOTIFICATION_SERVICE, firebaseConfig.messagingSenderId)
  }

  // TODO maybe handle duplicated notifications
  // TODO allow to deregister
  onNotification (callback: (callback: {}) => void) {
    ipcRenderer.on(ON_NOTIFICATION_RECEIVED, (_, notification) => {
      console.log(`Notification type: ${typeof notification}`)
      console.log(`Notification: ${JSON.stringify(notification)}`)
      callback(notification)
    })
  }

  updateToken (token: string) {
    console.log(`Token: ${token}`)
    // TODO handle promise
    database.ref(`${auth.currentUser?.uid}/heads/desk-clock`)
      .set({ messagingToken: token })
  }
}

export { CloudMessaging }
