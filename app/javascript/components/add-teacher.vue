<template>
  <el-form ref="form" :model="prof" label-width="120px">
    <h3>Add a new Professor</h3>



    <!-- <el-form-item label="first name" prop="firstname">
      <el-input v-model="prof.user_attributes.frst_name"
      @blur="$v.prof.user_attributes.frst_name.$touch()"></el-input>
    </el-form-item>
    <template v-if="$v.prof.user_attributes.frst_name.$error">
      <p v-if="$v.prof.user_attributes.frst_name.required">first name is required</p>
    </template> -->

    <el-form-item label="first name" prop="firstname">
      <el-input v-model="prof.user_attributes.frst_name"></el-input>
    </el-form-item>

    <el-form-item label="last name" prop="lastname">
      <el-input v-model="prof.user_attributes.last_name"></el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="prof.user_attributes.code"></el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="prof.user_attributes.email"></el-input>
    </el-form-item>

    <el-form-item label="password" prop="password">
      <el-input v-model="prof.user_attributes.password"></el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="prof.user_attributes.password_confirmation"></el-input>
    </el-form-item>

     <el-form-item label="college" prop="college">
      <el-input v-model="prof.college"></el-input>
    </el-form-item>

     <el-form-item label="experience" prop="experience">
      <el-input v-model="prof.experience"></el-input>
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
      <el-button type="primary" @click="onsubmit">Create</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
import axios from 'axios';
import { required } from 'vuelidate/lib/validators'
export default {
  data() {
    return {
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
      // rules: {
      //   firstname: [
      //     { required: true, message: 'Please input first name', trigger: 'blur' }
      //   ],
      //   lastname: [
      //     { required: true, message: 'Please input last name', trigger: 'blur' }
      //   ],
      //   code: [
      //     { required: true, message: 'Please input the code', trigger: 'blur' }
      //   ],
      //   college: [
      //     { required: true, message: 'Please input the college', trigger: 'blur' }
      //   ],
      //   experience: [
      //     { required: true, message: 'Please input the experience', trigger: 'blur' }
      //   ],
      //   password: [
      //     { required: true, message: 'Please input password (atleast 6 characters)', trigger: 'blur'},
      //     { min: 6, message: 'Length should be higher than 6 characters', trigger: 'blur' }
      //   ],
      //   date2: [
      //     { type: 'date', required: true, message: 'Please pick a time', trigger: 'change' }
      //   ],
      //   type: [
      //     { type: 'array', required: true, message: 'Please select at least one activity type', trigger: 'change' }
      //   ],
      //   resource: [
      //     { required: true, message: 'Please select activity resource', trigger: 'change' }
      //   ],
      //   desc: [
      //     { required: true, message: 'Please input activity form', trigger: 'blur' }
      //   ]
      // }
    }
  },
  // validations: {
  //   prof: {
  //     college: { required },
  //     experience: { required },
  //     user_attributes: {
  //             frst_name: { required },
  //             last_name: { required },
  //             email: { required },
  //             code: { required },
  //             password: { required },
  //             password_confirmation: { required }
  //           }
  //   }
  // },
  methods: {
    cancel(){
      this.$router.push({ name: 'teachers'})
    },
    onsubmit() {
      this.axios.post('/profs', this.prof )
      .then((Response) => {
        if(Response.data.included[0].attributes.frst_name && Response.data.included[0].attributes.frst_name == this.prof.user_attributes.frst_name)
          alert("professor was created!")
          location.reload()
      })
    }
  }
}
</script>