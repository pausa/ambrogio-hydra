import { ipcRenderer } from 'electron'
import { auth, config as firebaseConfig, database } from '@/service/firebase'
import {
  START_NOTIFICATION_SERVICE,
  NOTIFICATION_SERVICE_STARTED,
  NOTIFICATION_SERVICE_ERROR,
  NOTIFICATION_RECEIVED as ON_NOTIFICATION_RECEIVED,
  TOKEN_UPDATED
} from 'electron-push-receiver'

class Message {
  // eslint-disable-next-line no-useless-constructor
  constructor (readonly title: string, readonly text: string) {
  }
}

class CloudMessaging {
  constructor () {
    this.clearListeners()
    auth.onAuthStateChanged((user) => {
      if (user) {
        // notification should be init only after registered to firebase
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

  clearListeners () {
    ipcRenderer.removeAllListeners(NOTIFICATION_SERVICE_ERROR)
    ipcRenderer.removeAllListeners(NOTIFICATION_SERVICE_STARTED)
    ipcRenderer.removeAllListeners(TOKEN_UPDATED)
    ipcRenderer.removeAllListeners(START_NOTIFICATION_SERVICE)
    ipcRenderer.removeAllListeners(ON_NOTIFICATION_RECEIVED)
  }

  // TODO allow to deregister
  onNotification (callback: (message: Message) => void) {
    ipcRenderer.on(ON_NOTIFICATION_RECEIVED, (_, notification) => {
      console.log(`Notification type: ${typeof notification}`)
      console.log(`Notification: ${JSON.stringify(notification)}`)
      const message = new Message(notification.notification.title, notification.notification.body)
      callback(message)
    })
  }

  updateToken (token: string) {
    console.log(`Token: ${token}`)
    // TODO handle promise
    database.ref(`${auth.currentUser?.uid}/heads/desk-clock`)
      .set({ messagingToken: token })
  }
}

const messagingService = new CloudMessaging()
export { messagingService, Message }
