<template>
  <div>
    <div class= 'rightbar'>
      <div class="userinfo">
        <p font-size="20px"> acom golestan </p>
        <img src= "../../assets/images/play1.jpeg" class="userpic" />
        <p class="info">
          Name:<br/>
          Code:
        </p>
      </div>
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
      </div>
    </div>
  </div>
</template>

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
    float: left;
    height: 10%;
    top: 20%;
    right: 15%;
    font-size: 15px;
  }
</style>