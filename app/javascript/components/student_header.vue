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
        <el-button class="exit" @click="logOut()">
            Exit
          </el-button>
      </div>
    </div>
  </div>
</template>

<script>
import store from '../store/index'
import axios from 'axios';

export default {
  computed: {
    getting_user() {
      return store.getters.get_user
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
    }
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