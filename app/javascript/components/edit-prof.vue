<template>
  <el-form ref="teacher" :rules="rules" :model="teacher"  label-width="120px">

    <h3>Edit Professor</h3>

    <el-form-item label="first name" prop="frst_name">
      <el-input v-model="teacher.frst_name">
      </el-input>
    </el-form-item>

    <el-form-item label="last name" prop="last_name">
      <el-input v-model="teacher.last_name">
      </el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="teacher.code">
      </el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="teacher.email">
      </el-input>
    </el-form-item>

    <!-- <el-form-item label="password" prop="password">
      <el-input v-model="prof.user_attributes.password">
      </el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="prof.user_attributes.password_confirmation">
      </el-input>
    </el-form-item> -->

     <el-form-item label="experience" prop="experience">
      <el-input v-model="teacher.experience"></el-input>
    </el-form-item>

    <el-form-item label="college">
      <el-input v-model="teacher.college"></el-input>
    </el-form-item>


    <el-form-item>
      <el-button type="primary" @click="updateprof('teacher')">Update</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>

  </el-form>
</template>
<script>
export default {
  props: {
    profId: {
      type: String,
      required: true,
    }
  },

  data() {
    return {
      teacher:{
        college: "",
        experience: "",
        frst_name: "",
        last_name: "",
        email: "",
        code: "",
      },
      prof: {
        college: "",
        experience: "",
        user_attributes: {
          id: "",
          profile: "my picture",
          frst_name: "",
          last_name: "",
          email: "",
          code: "",
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
  created() {
    this.axios.get('/profs/' + this.profId)
      .then((response) => {
        this.prof.user_attributes.id = response.data.included[0].id
        this.teacher.college = response.data.data.attributes.college
        this.teacher.experience = response.data.data.attributes.experience
        this.teacher.frst_name = response.data.included[0].attributes.frst_name
        this.teacher.last_name = response.data.included[0].attributes.last_name
        this.teacher.email = response.data.included[0].attributes.email
        this.teacher.code = response.data.included[0].attributes.code
      })

  },
  methods: {
    cancel(){
      this.$router.push({ name: 'teachers'})
    },
    updateprof(formName) {
      this.$refs[formName].validate((valid) => {
        if(valid){
          this.prof.college = this.teacher.college
          this.prof.experience = this.teacher.experience
          this.prof.user_attributes.frst_name = this.teacher.frst_name
          this.prof.user_attributes.last_name = this.teacher.last_name
          this.prof.user_attributes.email = this.teacher.email
          this.prof.user_attributes.code = this.teacher.code

          this.axios.patch('/profs/' + this.profId, { prof: this.prof })
          .then((response) => {
            // console.log(response)
            alert("professor's info was updated!")
            location.reload()
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