<template>
  <el-form ref="form" :model="student" label-width="120px">
    <h3>Add a new Student</h3>

    <el-form-item label="first name" prop="firstname">
      <el-input v-model="student.user_attributes.frst_name"></el-input>
    </el-form-item>

    <el-form-item label="last name" prop="lastname">
      <el-input v-model="student.user_attributes.last_name"></el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="student.user_attributes.code"></el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="student.user_attributes.email"></el-input>
    </el-form-item>

    <el-form-item label="password" prop="password">
      <el-input v-model="student.user_attributes.password"></el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="student.user_attributes.password_confirmation"></el-input>
    </el-form-item>

    <el-form-item label="birthPlace" prop="college">
      <el-input v-model="student.birthPlace"></el-input>
    </el-form-item>

    <el-form-item label="rank" prop="experience">
      <el-input v-model="student.rank"></el-input>
    </el-form-item>

    <el-form-item label="lessons" prop="experience">
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
      <el-button type="primary" @click="savestudent()">Create</el-button>
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
    }
  },
  methods: {
    cancel(){
      this.$router.push({ name: 'interns'})
    },
    savestudent(){
      for(var i = 0; i < this.values.length; i++){
        this.student.stusons_attributes.push({ lesson: this.values[i].id, mark: '' })
      };
      this.axios.post("/students", this.student)
      .then(response => {
        alert("Student was created!")
        location.reload()
      })
    }
  },
  created(){
    this.axios.get('/fields')
    .then(response => {
      this.fileds = response.data
      this.lessons = deserialize(this.fileds)
      // console.log(this.lessons)
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