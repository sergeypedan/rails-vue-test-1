<template>
  <nav class="navbar navbar-expand-sm navbar-light bg-light">
    <div class="container">
      <a class="navbar-brand" href="/">Record Store</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            <router-link class="nav-link" v-if="!signedIn()" to="/">Sign in</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" v-if="!signedIn()" to="/signup">Sign Up</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" v-if="signedIn()"  to="/records">Records</router-link>
          </li>
          <li class="nav-item">
            <router-link class="nav-link" v-if="signedIn()"  to="/artists">Artists</router-link>
          </li>
          <li class="nav-item">
            <a href="#" @click.prevent="signOut" class="nav-link" v-if="signedIn()">Sign out</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: 'Header',
  created () {
    this.signedIn()
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    },
    signedIn () {
      return localStorage.signedIn
    },
    signOut () {
      this.$http.secured.delete('/signin')
        .then(response => {
          delete localStorage.csrf
          delete localStorage.signedIn
          this.$router.replace('/')
        })
        .catch(error => this.setError(error, 'Cannot sign out'))
    }
  }
}
</script>
