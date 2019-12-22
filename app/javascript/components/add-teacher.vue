<template>
  <el-form ref="teacher" :rules="rules" :model="teacher" label-width="120px">
    <h3>Add a new Professor</h3>

    <el-form-item label="first name" prop="frst_name">
      <el-input v-model="teacher.frst_name"></el-input>
    </el-form-item>

    <el-form-item label="last name" prop="last_name">
      <el-input v-model="teacher.last_name"></el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="teacher.code"></el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="teacher.email"></el-input>
    </el-form-item>

    <el-form-item label="password" prop="password">
      <el-input v-model="teacher.password"></el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="teacher.password_confirmation"></el-input>
    </el-form-item>

     <el-form-item label="college" prop="college">
      <el-input v-model="teacher.college"></el-input>
    </el-form-item>

     <el-form-item label="experience" prop="experience">
      <el-input v-model="teacher.experience"></el-input>
    </el-form-item>

    <!-- <el-form-item label="Profile" prop="profile">
      <el-upload
        ref="upload"
        action=""
        :auto-upload="true">
        <el-button size="small" type="primary">Upload</el-button>
      </el-upload>
    </el-form-item> -->

    <el-form-item>
      <el-button type="primary" @click="onsubmit('teacher')">Create</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
import axios from 'axios';
export default {
  data() {
    return {
      validators:{
        frst_name: false,
        last_name: false,
        college: false,
        experience: false,
        email: false,
        code: false,
        pass1: false,
        pass2: false
      },
      teacher:{
        frst_name: "",
        last_name: "",
        college: "",
        experience: "",
        profile: "my picture",
        email: "",
        code: "",
        password: "",
        password_confirmation: ""
      },
      prof: {
        college: "",
        experience: "",
        user_attributes: {
          profile: "my picture",
          frst_name: "",
          last_name: "",
          email: "",
          code: "",
          password: "",
          password_confirmation: ""
        }
      },
      rules: {
        frst_name: [
          { required: true, message: 'Please input first name', trigger: 'blur' }
        ],
        last_name: [
          { required: true, message: 'Please input last name', trigger: 'blur' }
        ],
        code: [
          { required: true, message: 'Please input code', trigger: 'blur' }
        ],
        email: [
          { required: true, message: 'Please input email', trigger: 'blur' },
          { type: 'email', message: 'Please input correct email address', trigger: ['blur', 'change'] }
        ],
        college: [
          { required: true, message: 'Please input college name', trigger: 'blur' }
        ],
        experience: [
          { required: true, message: 'Please input the experience', trigger: 'blur' }
        ],
        password: [
          { required: true, message: 'Please input password', trigger: 'blur' }
        ],
        password_confirmation: [
          { required: true, message: 'Please input password again', trigger: 'blur' }
        ],
      }
    }
  },
  methods: {
    cancel(){
      this.$router.push({ name: 'teachers'})
    },
    onsubmit(formName) {
      this.$refs[formName].validate((valid) => {
        if(valid){
          this.prof.college = this.teacher.college
          this.prof.experience = this.teacher.experience
          this.prof.user_attributes.frst_name = this.teacher.frst_name
          this.prof.user_attributes.last_name = this.teacher.last_name
          this.prof.user_attributes.code = this.teacher.code
          this.prof.user_attributes.email = this.teacher.email
          this.prof.user_attributes.password = this.teacher.password
          this.prof.user_attributes.password_confirmation = this.teacher.password_confirmation

          this.axios.post('/profs', this.prof )
          .then((Response) => {
            if(Response.data.included[0].attributes.frst_name && Response.data.included[0].attributes.frst_name == this.prof.user_attributes.frst_name){
              alert("professor was created!")
              location.reload()
            }
          })
        }
        else{
          console.log("its not valid")
          alert("please fill in the Fields")
        }
      })
    }
  }
}
</script>