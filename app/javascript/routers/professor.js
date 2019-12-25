import VueRouter from 'vue-router'
import Vue from 'vue'
import teachersView from "../components/teacher_view.vue"
import EditMark from "../components/edit_mark.vue"
import welcome from "../components/welcome.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/",
    name: "welcome",
    component: welcome
  },
  {
    path: "/interns/:id",
    name: "teachersView",
    component: teachersView,
    props: true
  },
  {
    path: "/interns/marking/:id",
    name: "EditMark",
    component: EditMark,
    props: true
  }
]

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes
})

export default router