<template>
  <div class="notification">
    <div v-if="show">
      <div class="line"></div>
      <div class="title">{{ message.title }}</div>
      <div class="text">{{ message.text }}</div>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import Component from 'vue-class-component'
import { auth } from '@/service/firebase'
import { messagingService } from '@/service/cloudMessaging'

class Message {
  // eslint-disable-next-line no-useless-constructor
  constructor (readonly title: string, readonly text: string) {
  }
}

@Component
export default class Notification extends Vue {
  show = false
  messaging = messagingService
  // TODO scrolling
  message: Message | null = null;
  messageQueue: Message[] = [];
  timeout: NodeJS.Timeout | null = null;

  mounted () {
    this.messaging.onNotification(not => console.log('YAY'))
    setTimeout(this.testNotifications, 1000)
    setTimeout(this.testNotifications, 18000)
    auth.onAuthStateChanged((user) => {
      if (user) {
        this.push('Info', `Logged in as: ${user.email}`)
      }
    })
  }

  testNotifications () {
    this.push('info', '1')
    this.push('info', '2')
    this.push('info', '3')
  }

  push (title: string, text: string) {
    this.messageQueue.push(new Message(title, text))
    this.display()
  }

  display () {
    if (!this.timeout) {
      const msg = this.messageQueue.shift()
      if (msg === undefined) {
        this.show = false
      } else {
        this.message = msg
        this.show = true
        this.timeout = setTimeout(() => {
          this.timeout = null
          this.display()
        }, 5000)
      }
    }
  }

  hide () {
    this.show = false
  }
}
</script>

<style scoped>
 @keyframes progress {
   from {width: 100%}
   to {width: 0 }
 }
 .line {
   border-top: 1px solid;
   padding-bottom: 0.25em;
   animation: progress 5s linear infinite;
 }
 .title{
   font-weight: bold;
   font-size: 1.25em;
 }
 .text{
   font-size: 1em;
 }
</style>
