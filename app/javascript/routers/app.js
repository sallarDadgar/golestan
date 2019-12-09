// import routes from '../routes/routes'
import VueRouter from 'vue-router'
import Vue from 'vue'
import teachers from "../components/teachers.vue"
import majors from "../components/majors.vue"
import lessons from "../components/lessons.vue"
import interns from "../components/interns.vue"
import AddTeacher from "../components/add-teacher.vue"
import EditTeacher from "../components/edit-teacher.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/teachers",
    name: "teachers",
    component: teachers,
  },
  {
    path: "/add-teachers",
    name: "addteachers",
    component: AddTeacher,
  },
  {
    path: "/edit-teachers",
    name: "editteachers",
    component: EditTeacher,
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