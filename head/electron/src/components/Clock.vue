<template>
  <div class="clock">
    <div class="hours">{{ hours }}</div>
    <div class="separator">:</div>
    <div class="minutes">{{ minutes }}</div>
  </div>
</template>

<script>
import Vue from 'vue'
import Component from 'vue-class-component'
import moment from 'moment'

@Component
export default class Clock extends Vue {
  hours = 99;
  minutes = 11;

  updater = null;

  updateTime () {
    const m = moment()
    this.hours = this.padded(m.hour())
    this.minutes = this.padded(m.minute())
  }

  padded (n) {
    return ('0' + n).slice(-2)
  }

  mounted () {
    this.updateTime()
    this.updater = setInterval(this.updateTime, 1000)
  }

  destroyed () {
    clearInterval(this.updater)
  }
}
</script>

<style scoped>
@keyframes blinker {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0;
  }
  100% {
    opacity: 1;
  }
}

.clock {
  display: flex;
  justify-content: center;
  align-content: center;
  align-items: center;
}

.separator {
  animation: blinker 1s step-end infinite;
}

.hours {
  flex-basis: 1.3em;
}

.minutes {
  flex-basis: 1.3em;
}

</style>
