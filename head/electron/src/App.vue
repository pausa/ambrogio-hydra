<template>
  <div id="app">
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
export default class App extends Vue {}
</script>

<style>
body{
  display: flex;
  flex-direction: column;
  background-color: black;
  /* TODO maybe font size should be relative to window size */
  font-size: 100%;
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: white;
}
.clock{
  font-size: 7em;
}
.calendar{
  font-size: 2em;
}
.notification {
  font-size: 4em;
}
</style>
