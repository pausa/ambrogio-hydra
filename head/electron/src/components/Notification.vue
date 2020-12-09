<template>
  <div class="notification">
    <div class="text">{{ text }}</div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import Component from 'vue-class-component'
import { auth } from '@/service/firebase'
import { CloudMessaging } from '@/service/cloudMessaging'

@Component
export default class Notification extends Vue {
  text: string | null = null
  messaging: CloudMessaging | null = null

  mounted () {
    auth.onAuthStateChanged((user) => {
      if (user) {
        // todo make this an actual notification
        this.text = `Logged in as: ${user.email}`
        // TODO maybe not do it everytime the user changes
        this.messaging = new CloudMessaging()
        this.messaging.onNotification(not => console.log('YAY'))
      }
    })
  }
/**
  subscribe () {
    messaging.getToken({ vapidKey: this.publicKey })
      .then(token => {
        console.log('received token')
        if (token) {
          database.ref(`${auth.currentUser?.uid}/heads/desk-clock`)
            .set({ messagingToken: token })
        }
      }).catch((err) => {
        console.log('An error occurred while retrieving token. ', err)
      })
  }
 */
}
</script>

<style scoped>
</style>
