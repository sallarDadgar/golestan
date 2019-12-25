// import routes from '../routes/routes'
import VueRouter from 'vue-router'
import Vue from 'vue'
import welcome from "../components/welcome.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/",
    name: "welcome",
    component: welcome
  },
]

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes
})

export default router