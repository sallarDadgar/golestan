// import routes from '../routes/routes'
import VueRouter from 'vue-router'
import Vue from 'vue'
import Home from "../components/home.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/",
    name: "home",
    component: Home,
  },
  {
    path: '*',
    redirect: { name: 'home' }
  }
]

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes
})

export default router