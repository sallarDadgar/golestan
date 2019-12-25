<template>
<div>
  <div class= 'rightbar'>
      <div class="userinfo">
        <p font-size="20px"> acom golestan </p>
        <img src= "../../assets/images/play1.jpeg" class="userpic" />
        <p class="info">
          Name:<br/>{{getting_user.frst_name}} {{getting_user.last_name}}<br/>
          Code:<br/>{{getting_user.code}}
        </p>
      </div>
      <div class="btns">
        <div v-for="item in teachers_lessons" v-bind:key="item">
          <el-button class="btn" @click="ShowTeachersStudents(item.id)">
            {{item.title}}
          </el-button>
        </div>
        <el-button class="exit" @click="logOut()">
          Exit
        </el-button>
      </div>
    </div>
  </div>
</template>
<script>
import store from '../store/index'
var deserialize = require('jsonapi-deserializer').deserialize;

export default {
  data() {
    return {
      lessons: [],
      teachers_lessons: []
    }
  },
  computed: {
    getting_user() {
      return store.getters.get_user
    },
    getting_bool(){
      return store.getters.get_bool
    }
  },
  methods: {
    logOut(){
      if(confirm("are you sure you want to log out?")){
        this.axios.delete('/users/sign_out')
        .then(Response => {
          location.reload()
        })
      }
    },
    ShowTeachersStudents(lessonid){
        this.$router.push({name: 'teachersView', params: {id: lessonid}})
    }
  },
  created() {
    this.axios.get('/fields')
    .then(response => {
      this.lessons = deserialize(response.data)

      for(var i = 0; i<this.lessons.length; i++){
        if(this.lessons[i].projor.prof == this.getting_user.fkey_id){
          this.teachers_lessons.push({id: this.lessons[i].id, title: this.lessons[i].title})
        }
      }
    })
    this.axios.get('/stusons')
    .then(response => {
      store.dispatch('initialStusons', response.data.data)
    })
  }
}
</script>

<style>
  .btn {
    width: 100%;
    right: 0;
  }
  .btns {
    width: 100%;
    right: 0;
    height: 70%;
    float: bottom;
  }
  .maindiv {
  width: 80%;
  float: left;
  height: 100%;
  }
  .rightbar {
    float: right !important;
    position: fixed;
    top: 0;
    right: 0;
    width: 20%;
    height: 100%;
  }

  .userinfo {
    top: 0;
    width: 100%;
    height: 40%;
  }

  .userpic {
    position: fixed;
    top: 20%;
    right: 20px;
    width: 5%;
    height: 15%;
    object-fit: cover;
  }

  .info {
    position: fixed;
    float: right;
    height: 10%;
    top: 20%;
    font-size: 15px;
  }
  .exit{
    width: 100%;
    float: bottom;
  }
</style>