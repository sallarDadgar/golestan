<template>
  <div>
    <div class= 'rightbar'>
      <div class="userinfo">
        <p font-size="20px"> acom golestan </p>
        <hr/>
        <img src= "../../assets/images/play1.jpeg" class="userpic" />
        <p class="info">
          Name:<br/>{{getting_user.frst_name}} {{getting_user.last_name}}<br/>
          Code:<br/>{{getting_user.code}}
        </p>
      </div>
      <hr/>
      <div class="btns">
        <router-link to="/teachers">
          <el-button class="btn">
            managing teachers
          </el-button>
        </router-link>
        <router-link to="/majors">
          <el-button class="btn">
            managing majors
          </el-button>
        </router-link>
        <router-link to="/lessons">
          <el-button class="btn">
            managing lessons
          </el-button>
        </router-link>
        <router-link to="/interns">
          <el-button class="btn">
            managing students
          </el-button>
        </router-link>
        <el-button class="exit" @click="onsubmit()">
          Exit
        </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import store from '../store/index'

export default {
  computed: {
    getting_user() {
      return store.getters.get_user
    }
  },
  // created() {this.user_code = this.$store.getters.get_user.data.code},
  methods: {
    onsubmit(){
      if(confirm("are you sure you want to log out?")){
        this.axios.delete('/users/sign_out')
        .then(Response => {
          location.reload()
        })
      }
    }
  }
}
</script>

<style>
  .btn {
    width: 100%;
    right: 0;
    background-color: yellow
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
    background-color: whitesmoke;
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
    background-color: orange;
  }
</style>