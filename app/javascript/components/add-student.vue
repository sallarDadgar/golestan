<template>
  <el-form ref="apprentice" :rules="rules" :model="apprentice" label-width="120px">
    <h3>Add a new Student</h3>

    <el-form-item label="first name" prop="frst_name">
      <el-input v-model="apprentice.frst_name"></el-input>
    </el-form-item>

    <el-form-item label="last name" prop="last_name">
      <el-input v-model="apprentice.last_name"></el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="apprentice.code"></el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="apprentice.email"></el-input>
    </el-form-item>

    <el-form-item label="password" prop="password">
      <el-input v-model="apprentice.password"></el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="apprentice.password_confirmation"></el-input>
    </el-form-item>

    <el-form-item label="birthPlace" prop="birthPlace">
      <el-input v-model="apprentice.birthPlace"></el-input>
    </el-form-item>

    <el-form-item label="rank" prop="rank">
      <el-input v-model="apprentice.rank"></el-input>
    </el-form-item>

    <el-form-item label="lessons">
      <multiselect v-model="values" :options="lessons" :multiple="true"
      :close-on-select="false" :clear-on-select="false"
      :preserve-search="true" placeholder="   Pick some"
      label="title" track-by="title" :preselect-first="true">
        <template slot="selection" slot-scope="{ values, search, isOpen }">
          <span v-if="values.length &amp;&amp;
          !isOpen">{{ values.length }} options selected</span>
        </template>
      </multiselect>
    </el-form-item>

    <el-form-item>
      <el-button type="primary" @click="savestudent('apprentice')">Create</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>
  </el-form>
</template>
<script>
import axios from 'axios';
import Multiselect from 'vue-multiselect'
import { required } from 'vuelidate/lib/validators'
var deserialize = require('jsonapi-deserializer').deserialize;
export default {
  components: {
    Multiselect
  },
  data() {
    return {
      values: [],
      fileds: [],
      lessons: [],
      apprentice:{
        birthPlace: "",
        rank: "",
        profile: "my picture",
        frst_name: "",
        last_name: "",
        email: "",
        code: "",
        password: "",
        password_confirmation: ""
      },
      student: {
        birthPlace: "",
        rank: "",
        user_attributes: {
                profile: "my picture",
                frst_name: "",
                last_name: "",
                email: "",
                code: "",
                password: "",
                password_confirmation: ""
              },
            stusons_attributes: [
            ]
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
        birthPlace: [
          { required: true, message: 'Please input birth place', trigger: 'blur' }
        ],
        rank: [
          { required: true, message: 'Please input the rank', trigger: 'blur' }
        ],
        password: [
          { required: true, message: 'Please input password', trigger: 'blur' },
          { min: 6, message: 'Length should at laest 6 chaaracters', trigger: 'blur' }
        ],
        password_confirmation: [
          { required: true, message: 'Please input password again', trigger: 'blur' }
        ],
      }
    }
  },
  methods: {
    cancel(){
      this.$router.push({ name: 'interns'})
    },
    savestudent(formName){
      this.$refs[formName].validate((valid) => {
        if(valid){
          this.student.birthPlace = this.apprentice.birthPlace
          this.student.rank = this.apprentice.rank
          this.student.user_attributes.frst_name = this.apprentice.frst_name
          this.student.user_attributes.last_name = this.apprentice.last_name
          this.student.user_attributes.code = this.apprentice.code
          this.student.user_attributes.email = this.apprentice.email
          this.student.user_attributes.password_confirmation = this.apprentice.password_confirmation
          this.student.user_attributes.password = this.apprentice.password

          for(var i = 0; i < this.values.length; i++){
            this.student.stusons_attributes.push({ lesson: this.values[i].id, mark: '' })
          };
          this.axios.post("/students", this.student)
          .then(response => {
            alert("Student was created!")
            location.reload()
          })
        }
        else{
          alert("please fill in the Fields")
        }
      })
    }
  },
  created(){
    this.axios.get('/fields')
    .then(response => {
      this.fileds = response.data
      this.lessons = deserialize(this.fileds)
    })
  }
}
</script>

<style>
/* .multiselect{
  display: inline-block;
  border: 1px solid #adadad;
  width: 100%;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 12px;
  font-weight: 400;
  line-height: 1.1;
  text-align: left;
  vertical-align: middle;
  cursor: pointer;
  background-image: none;
  border-radius: 4px;
} */
</style>