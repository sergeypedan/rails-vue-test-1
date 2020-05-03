<template>
  <div class="container">
    <div class="card mr-auto ml-auto my-4 shadow-sm" style="max-width: 400px">
      <div class="card-body p-5">
        <h1 class="card-title h2 mb-4">Sign in</h1>

        <form @submit.prevent="signin">
          <div class="form-group">
            <label for="email">E-mail</label>
            <input  id="email" type="email" name="email" v-model="email" class="form-control form-control-lg" required="" placeholder="username@domain.com">
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input  id="password" type="password" name="password" v-model="password" class="form-control form-control-lg" required="" placeholder="••••••••••••">
          </div>

          <div class="alert alert-danger" v-if="error">{{error}}</div>

          <button type="submit" class="btn btn-success btn-block btn-lg mt-4">Sign In</button>
        </form>
      </div>
      <div class="card-footer text-center">
        <router-link to="/signup" class="">Sign up</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signin',
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain
        .post('/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
