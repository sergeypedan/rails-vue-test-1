/* eslint no-console: 0 */

import 'jquery'

// import 'bootstrap'
import 'bootstrap/dist/js/bootstrap.js'
// import 'bootstrap/js/dist/util'
// import 'bootstrap/js/dist/tab'
// import 'bootstrap/js/dist/toast'
// import 'bootstrap/js/dist/collapse'
// import 'bootstrap/js/dist/button'
// import 'bootstrap/js/dist/tooltip'
// import 'bootstrap/js/dist/popover'
// import 'bootstrap/js/dist/carousel'
// import 'bootstrap/js/dist/scrollspy'
// import 'bootstrap/js/dist/modal'
// import 'bootstrap/js/dist/dropdown'
// import 'bootstrap/js/dist/alert'


import '../stylesheets/application'

import Vue      from 'vue/dist/vue.esm'
import VueAxios from 'vue-axios'
import App      from '../components/app.vue'
import router   from '../modules/router'
import { securedAxiosInstance, plainAxiosInstance } from '../modules/axios-backend'


Vue.use(
  VueAxios,
  { secured: securedAxiosInstance, plain: plainAxiosInstance }
)

new Vue({
  el: '#record-store',
  router,
  plainAxiosInstance,
  securedAxiosInstance,
  components: { App },
  template: '<App/>'
})
