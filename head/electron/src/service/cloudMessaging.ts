import { auth, database } from '@/service/firebase'

class Message {
  // eslint-disable-next-line no-useless-constructor
  constructor (readonly title: string,
               readonly text: string,
               readonly uid?: string,
               readonly color: string = 'inherit') {
  }
}

class CloudMessaging {
  onNotification (callback: (message: Message) => void) {
    database.ref(`${auth.currentUser?.uid}/notifications/last-notification`)
      .on('value', snapshot => {
        console.log(`Notification: ${JSON.stringify(snapshot.val())}`)
        if (snapshot.val()) {
          console.log('Notification non null')
          callback(snapshot.val())
        }
      })
  }
}

const messagingService = new CloudMessaging()
export { messagingService, Message }
