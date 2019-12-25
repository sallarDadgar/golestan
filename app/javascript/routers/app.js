// import routes from '../routes/routes'
import VueRouter from 'vue-router'
import Vue from 'vue'
import teachers from "../components/teachers.vue"
import majors from "../components/majors.vue"
import lessons from "../components/lessons.vue"
import interns from "../components/interns.vue"
import AddTeacher from "../components/add-teacher.vue"
import editprof from "../components/edit-prof.vue"
import AddStudent from "../components/add-student.vue"
import showstudent from "../components/show-student.vue"
import editstudent from "../components/edit-student.vue"
import welcome from "../components/welcome.vue"

Vue.use(VueRouter)

const routes = [
  {
    path: "/",
    name: "welcome",
    component: welcome
  },
  {
    path: "/teachers",
    name: "teachers",
    component: teachers,
  },
  {
    path: "/edit-prof/:profId",
    name: "editprof",
    component: editprof,
    props: true
  },
  {
    path: "/edit-student/:id",
    name: "editstudent",
    component: editstudent,
    props: true
  },
  {
    path: "/show-student/:id",
    name: "showstudent",
    component: showstudent,
    props: true
  },
  {
    path: "/add-teachers",
    name: "addteachers",
    component: AddTeacher,
  },
  {
    path: "/add-students",
    name: "addstudents",
    component: AddStudent,
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