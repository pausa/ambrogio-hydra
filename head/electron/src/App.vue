<template>
  <div id="app"
       v-on:dblclick="toggleFullScreen"
       v-on:click="cycleSizes"
       v-bind:style="{ 'font-size': this.fontSizes[this.fontSizeIndex] }">
    <auth/>
    <clock class="clock"/>
    <calendar class="calendar"/>
    <notification class="notification"/>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import Clock from '@/components/Clock.vue'
import Calendar from '@/components/Calendar.vue'
import Auth from '@/components/Auth.vue'
import Notification from '@/components/Notification.vue'

@Component({
  components: {
    Clock,
    Calendar,
    Auth,
    Notification
  }
})
export default class App extends Vue {
  fontSizeIndex = 2
  fontSizes = ['200%', '250%', '300%', '50%', '75%', '100%', '150%']
  fullscreen = false

  toggleFullScreen () {
    if (this.fullscreen) {
      document.exitFullscreen()
      this.fullscreen = false
    } else {
      document.documentElement.requestFullscreen()
      this.fullscreen = true
    }
  }

  cycleSizes () {
    this.fontSizeIndex = (this.fontSizeIndex + 1) % this.fontSizes.length
  }
}
</script>

<style>
body {
  overflow: hidden;
  display: flex;
  flex-direction: column;
  background-color: black;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: white;
}
.clock {
  font-size: 7em;
}
.calendar {
  font-size: 2em;
}
.notification {
  margin-top: 0.5em;
  padding-left: 5%;
  padding-right: 5%;
  font-size: 1.5em;
}
</style>
