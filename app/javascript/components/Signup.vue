<template>
  <div class="container">
    <div class="card mr-auto ml-auto my-4 shadow-sm" style="max-width: 400px">
      <div class="card-body p-5">
        <h1 class="card-title h2 mb-4">Sign up</h1>

        <form @submit.prevent="signup">
          <div class="form-group">
            <label for="email">E-mail</label>
            <input  id="email" type="email" v-model="email" class="form-control form-control-lg" placeholder="username@domain.com">
          </div>

          <div class="form-group">
            <label for="password">Password</label>
            <input  id="password" type="password" v-model="password" class="form-control form-control-lg">
          </div>

          <div class="form-group">
            <label for="password_confirmation">Password confirmation</label>
            <input  id="password_confirmation" type="password" name="password_confirmation" v-model="password_confirmation" class="form-control form-control-lg" required="">
          </div>

          <div class="alert alert-danger" v-if="error">{{error}}</div>

          <button type="submit" class="btn btn-success btn-block btn-lg mt-4">Sign up</button>
        </form>
      </div>
      <div class="card-footer text-center">
        <router-link to="/">Sign in</router-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Signup',
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
      error: ''
    }
  },
  created () {
    this.checkedSignedIn()
  },
  updated () {
    this.checkedSignedIn()
  },
  methods: {
    signup () {
      this.$http.plain.post('/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }

      localStorage.csrf = response.data.csrf
      localStorage.signedIn = true
      this.error = ''
      this.$router.replace('/records')
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      delete localStorage.csrf
      delete localStorage.signedIn
    },
    checkedSignedIn () {
      if (localStorage.signedIn) {
        this.$router.replace('/records')
      }
    }
  }
}
</script>
