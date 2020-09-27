<template>
  <div class="calendar">
    {{ date }}
  </div>
</template>

<script>
import Vue from 'vue'
import Component from 'vue-class-component'
import moment from 'moment'

// TODO pass the locale
@Component
export default class Calendar extends Vue {
  date = 'NOPE';
  updater = null;

  updateTime () {
    this.date = moment().locale('it').format('LL')
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
.calendar {
  font-variant: small-caps;
}
</style>
