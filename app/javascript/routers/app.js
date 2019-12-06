// import routes from '../routes/routes'
import VueRouter from 'vue-router'
import Vue from 'vue'
import teachers from "../components/teachers.vue"
import majors from "../components/majors.vue"
import lessons from "../components/lessons.vue"
import interns from "../components/interns.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/teachers",
    name: "teachers",
    component: teachers,
  },
  {
    path: "/majors",
    name: "majors",
    component: majors,
  },
  {
    path: "/lessons",
    name: "lessons",
    component: lessons,
  },
  {
    path: "/interns",
    name: "interns",
    component: interns,
  }
]

const router = new VueRouter({
  mode: 'history',
  base: '/',
  routes
})

export default router