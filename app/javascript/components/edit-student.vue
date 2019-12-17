<template>
<el-form ref="form"  label-width="120px">

    <h3>Edit student</h3>

    <el-form-item label="first name" prop="firstname">
      <el-input v-model="student.user_attributes.frst_name">
      </el-input>
    </el-form-item>

    <el-form-item label="last name" prop="lastname">
      <el-input v-model="student.user_attributes.last_name">
      </el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="student.user_attributes.code">
      </el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="student.user_attributes.email">
      </el-input>
    </el-form-item>

     <el-form-item label="birthPlace" prop="experience">
      <el-input v-model="student.birthPlace"></el-input>
    </el-form-item>

    <el-form-item label="rank">
      <el-input v-model="student.rank"></el-input>
    </el-form-item>

    <el-form-item label="Courses">
    <ul>
        <li v-for="field in fieldnames" v-bind:key="field">
          {{field.course}}: {{field.mark}} <el-button @click="remove_selected_lesson(field.id, true)">
            <i class="fas fa-trash-alt" title="delete">
            </i>
            </el-button>
        </li>

        <li v-for="value in values" v-bind:key="value">
          {{value.title}}
          <!-- <el-button @click="remove_selected_lesson(value.id, false)">
          <i class="fas fa-trash-alt" title="delete">
          </i>
          </el-button> -->
        </li>
      </ul>
    </el-form-item>

    <el-form-item label="lessons" prop="experience">
      <multiselect v-model="values" :options="Multiselect_source" :multiple="true"
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
      <el-button type="primary">Update</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>

  </el-form>
</template>
<script>
import Multiselect from 'vue-multiselect'
var deserialize = require('jsonapi-deserializer').deserialize;
export default {
  components: {
    Multiselect
  },
  props: {
    id: {
      type: String,
      required: true,
    }
  },
  data(){
    return {
      student_lessons: [],
      fieldnames: [],
      Multiselect_source: [],
      values: [],
      fileds: [],
      fileds_taken: [],
      lessons: [],
      student: {
        birthPlace: "",
        rank: "",
        user_attributes: {
          id: "",
          profile: "my picture",
          frst_name: "",
          last_name: "",
          email: "",
          code: "",
        },
        stusons_attributes:[]
      },
    }
  },
  updated(){
    console.log(this.values)
  },
  methods: {
    cancel(){
      this.$router.push({ name: 'interns'})
    },
    remove_selected_lesson(hashid, conditionalBool){
      if(conditionalBool){
        this.fieldnames.splice(this.fieldnames.indexOf(this.fieldnames.find(
          f => f.id == hashid
        )), 1)

        this.Multiselect_source.push(this.lessons.find(
          l => l.id == hashid
        ))
      }
    }
  },
  created(){
    this.axios.get('/students/' + this.id)
    .then(response => {
      this.student.birthPlace = response.data.data.attributes.birthPlace
      this.student.rank = response.data.data.attributes.rank
      this.student.user_attributes.id = response.data.included[0].id
      this.student.user_attributes.frst_name = response.data.included[0].attributes.frst_name
      this.student.user_attributes.last_name = response.data.included[0].attributes.last_name
      this.student.user_attributes.email = response.data.included[0].attributes.email
      this.student.user_attributes.code = response.data.included[0].attributes.code
      for(var i = 1; i < response.data.included.length; i++){
        this.student_lessons.push(response.data.included[i])
      };
    })

    this.axios.get('/fields')
    .then(response => {
      this.fileds = response.data
      this.lessons = deserialize(this.fileds)
      this.Multiselect_source = deserialize(this.fileds)
      for(var j =0 ; j<response.data.data.length; j++){
        for(var i = 0; i < this.student_lessons.length; i++){
          if(this.student_lessons[i].attributes.lesson == response.data.data[j].id ){
            this.fieldnames.push({id: this.student_lessons[i].attributes.lesson,
              course: response.data.data[j].attributes.title,
              mark: this.student_lessons[i].attributes.mark})
          }
        };
      };
      for(var i = 0; i< this.fieldnames.length; i++){
        this.Multiselect_source.splice(this.Multiselect_source
        .indexOf(this.Multiselect_source.find(
          l => l.id == this.fieldnames[i].id
        )), 1)
      };
      console.log(this.Multiselect_source)
      console.log(this.lessons)
    })

  }
}
</script>