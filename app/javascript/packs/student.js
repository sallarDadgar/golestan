/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import axios from 'axios'
import VueRouter from 'vue-router'
import VueAxios from 'vue-axios'
import ElementUI from 'element-ui'
import lang from 'element-ui/lib/locale/lang/zh-TW'
import 'normalize.css'
import 'element-ui/lib/theme-chalk/index.css'
import student from '../panels/student.vue'
import router from '../routers/student'



import '@fortawesome/fontawesome-free/css/all.css'
import '@fortawesome/fontawesome-free/js/all.js'


Vue.use(VueAxios, axios)

Vue.use(ElementUI, { lang })
Vue.use(ElementUI)
Vue.use(VueRouter)

let token = document.getElementsByName('csrf-token')[0].getAttribute('content')
axios.defaults.headers.common['X-CSRF-Token'] = token

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(student),
    router
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})