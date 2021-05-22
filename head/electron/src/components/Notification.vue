<template>
  <div class="notification">
    <transition name="progress"
      v-on:after-leave="showPlaceholder = true; message = null"
      v-on:before-enter="showPlaceholder = false">
      <div v-if="showProgress" class="line" v-bind:style="{ 'color': message.color }"></div>
    </transition>
    <div v-if="showPlaceholder" class="line"></div>
    <transition name="fade">
      <div v-if="message !== null">
        <div class="title" v-bind:style="{ 'color': message.color }">{{ message.title }}</div>
        <div class="text">{{ message.text }}</div>
      </div>
    </transition>
</div>
</template>

<script lang="ts">
import Vue from 'vue'
import Component from 'vue-class-component'
import { auth } from '@/service/firebase'
import { messagingService, Message } from '@/service/cloudMessaging'

@Component
export default class Notification extends Vue {
  showProgress = false
  showPlaceholder = false
  messaging = messagingService
  // TODO scrolling
  message: Message | null = null;
  messageQueue: Message[] = [];
  timeout: NodeJS.Timeout | null = null;

  mounted () {
    auth.onAuthStateChanged((user) => {
      if (user) {
        this.push(new Message('Info', `Logged in as: ${user.email}`))
        // registering after log in, otherwise we cannot get messages
        this.messaging.onNotification(this.push)
      }
    })
  }

  push (message: Message) {
    this.messageQueue.push(message)
    this.display()
  }

  display () {
    if (!this.timeout) {
      const msg = this.messageQueue.shift()
      if (msg !== undefined) {
        this.message = msg
        this.showProgress = true
        this.timeout = setTimeout(this.hide, 100)
      }
    }
  }

  hide () {
    this.showProgress = false
    // at the end of the timeout we remove it and show a new notification,
    // if available
    this.timeout = setTimeout(() => {
      this.timeout = null
      this.display()
    }, 5000)
  }
}
</script>

<style scoped>
 @keyframes progress {
   from {width: 0}
   to {width: 100%}
 }

 /*noinspection CssUnusedSymbol*/
 .progress-enter-active {
   animation-duration: 0.10s;
   animation-timing-function: linear;
   animation-name: progress;
 }
 /*noinspection CssUnusedSymbol*/
 .progress-leave-active {
   animation-duration: 5s;
   animation-name: progress;
   animation-timing-function: linear;
   animation-direction: reverse;
 }
 /*noinspection CssUnusedSymbol*/
 .fade-enter-active, .fade-leave-active {
   transition-duration: 0.10s;
   transition-property: opacity
 }
 /*noinspection CssUnusedSymbol*/
 .fade-enter, .fade-leave-to {
   opacity: 0
 }
 .line {
   border-top: 1px solid;
   margin: auto;
   padding-bottom: 0.25em;
   width: 0;
 }
 .title{
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
   font-weight: bold;
   font-size: 1.25em;
 }
 .text{
   font-size: 1em;
 }
</style>
