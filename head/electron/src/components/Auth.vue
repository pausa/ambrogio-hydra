<template>
  <div class="auth">
    <div class="userCode" v-if="deviceCode !== null">User code: {{ userCode }}. Visit: {{ verificationUrl }}</div>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios'
import qs from 'querystring'
import Component from 'vue-class-component'
import { auth, googleAuthProvider } from '@/service/firebase'

@Component
export default class Auth extends Vue {
  clientId = '370597727411-sd0k1ldd21lb9mmatigvghdcfcq80sc9.apps.googleusercontent.com';
  clientSecret = 'RgLeM--FAuESycIaetH2dx2j'
  grantType = 'urn:ietf:params:oauth:grant-type:device_code'
  updater: NodeJS.Timeout | null = null
  userCode: string | null = null
  deviceCode: string | null = null
  verificationUrl: string | null = null

  mounted () {
    this.stopUpdater()
    auth.onAuthStateChanged((user) => {
      if (!user) {
        this.startLogin()
      }
    })
  }

  destroyed () {
    this.stopUpdater()
  }

  startLogin (): void {
    axios.request({
      method: 'post',
      url: 'https://oauth2.googleapis.com/device/code',
      data: qs.stringify({
        scope: ['profile', 'email'],
        // eslint-disable-next-line @typescript-eslint/camelcase
        client_id: this.clientId
      }),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }).then((result) => {
      this.userCode = result.data.user_code
      this.deviceCode = result.data.device_code
      this.verificationUrl = result.data.verification_url
      const millis = parseInt(result.data.interval) * 1000
      this.updater = setInterval(this.checkAuth, millis)
    })
  }

  checkAuth (): void {
    console.log('checking')
    axios.request({
      method: 'post',
      url: 'https://oauth2.googleapis.com/token',
      data: qs.stringify({
        // eslint-disable-next-line @typescript-eslint/camelcase
        client_id: this.clientId,
        // eslint-disable-next-line @typescript-eslint/camelcase
        client_secret: this.clientSecret,
        // eslint-disable-next-line @typescript-eslint/camelcase
        device_code: this.deviceCode,
        // eslint-disable-next-line @typescript-eslint/camelcase
        grant_type: this.grantType
      }),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    }).then((result) => {
      this.stopUpdater()
      this.deviceCode = null
      const cred = googleAuthProvider.credential(null, result.data.access_token)
      auth.signInWithCredential(cred)
        .catch(() => {
          this.startLogin()
        })
    }).catch(() => {
      // nothing to do
    })
  }

  stopUpdater () {
    if (this.updater !== null) {
      console.log('Clearing pending updater')
      clearInterval(this.updater)
      this.updater = null
    }
  }
}
</script>

<style scoped>
</style>
