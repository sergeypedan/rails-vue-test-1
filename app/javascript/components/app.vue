<template>
  <div id="app">
    <Header />
    <router-view/>
  </div>
</template>

<script>
import Header from './Header.vue'

export default {
  name: 'App',
  components: {
    Header
  }
}
</script>
