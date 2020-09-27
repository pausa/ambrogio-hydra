<template>
  <div id="app">
    <clock class="clock"/>
    <calendar class="calendar"/>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import Clock from '@/components/Clock.vue'
import Calendar from '@/components/Calendar.vue'

@Component({
  components: {
    Clock,
    Calendar
  }
})
export default class App extends Vue {}
</script>

<style>
body{
  display: flex;
  flex-direction: column;
  background-color: black;
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
</style>
