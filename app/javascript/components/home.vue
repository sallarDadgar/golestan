<template>
<div>
  <el-form ref="form" label-width="140px">
    <el-form-item label="COM_email">
      <el-input v-model="user.email"
        placeholder="Enter email">
      </el-input>
    </el-form-item>

    <el-form-item label="password">
      <el-input v-model="user.password"
        placeholder="Password">
      </el-input>
    </el-form-item>
    <el-form-item>
      <el-button
        @click="loginSubmit"
        type="success"
        size="small">log in
      </el-button>
    </el-form-item>
  </el-form>
</div>

</template>
<script>
// import Header from "./header.vue"
export default {
  name: 'Login',
  data(){
    return {
      user: {
          email: "",
          password: ""
      }
    }
  },
  // components: {
  //     Header
  // },
  methods: {
    loginSubmit() {
      this.axios.post('/users/sign_in', this.user)
      .then(response => {
        console.log(response)
        // response['data']
        }
      )
      // redirect_to: "application#app"
    }
  }
}
</script>