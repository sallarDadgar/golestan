<template>
<el-form ref="apprentice" :rules="rules" :model="apprentice" label-width="120px">

    <h3>Edit student</h3>

    <el-form-item label="first name" prop="frst_name">
      <el-input v-model="apprentice.frst_name">
      </el-input>
    </el-form-item>

    <el-form-item label="last name" prop="last_name">
      <el-input v-model="apprentice.last_name">
      </el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="apprentice.code">
      </el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="apprentice.email">
      </el-input>
    </el-form-item>

     <el-form-item label="birthPlace" prop="birthPlace">
      <el-input v-model="apprentice.birthPlace"></el-input>
    </el-form-item>

    <el-form-item label="rank" prop="rank">
      <el-input v-model="apprentice.rank"></el-input>
    </el-form-item>

    <el-form-item label="Courses">
    <ul>
        <li v-for="field in fieldnames" v-bind:key="field">
          {{field.course}}: {{field.mark}} <el-button @click="remove_selected_lesson(field.id)">
            <i class="fas fa-trash-alt" title="delete">
            </i>
            </el-button>
        </li>

        <li v-for="value in values" v-bind:key="value">
          {{value.title}}
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
      <el-button type="primary" @click="updatestudent('apprentice')">Update</el-button>
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
          { required: true, message: 'Please input password', trigger: 'blur' }
        ],
        password_confirmation: [
          { required: true, message: 'Please input password again', trigger: 'blur' }
        ],
      },
      student_ID: 0,
      student_included_id: [],
      valueIds_to_be_deleted: [],
      removed_ids_to_be_deleted: [],
      condiltional_helping_bool: false,
      removed_marked_lessons: [],
      student_lessons: [],
      fieldnames: [],
      Multiselect_source: [],
      values: [],
      fileds: [],
      fileds_taken: [],
      lessons: [],

      apprentice: {
        birthPlace: "",
        rank: "",
        userId: 0,
        profile: "my picture",
        frst_name: "",
        last_name: "",
        email: "",
        code: "",
      },

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
  methods: {
    updatestudent(formName){
       this.$refs[formName].validate((valid) => {
        if(valid){
          this.student.birthPlace = this.apprentice.birthPlace
          this.student.rank = this.apprentice.rank
          this.student.user_attributes.id = this.apprentice.userId
          this.student.user_attributes.frst_name = this.apprentice.frst_name
          this.student.user_attributes.last_name = this.apprentice.last_name
          this.student.user_attributes.email = this.apprentice.email
          this.student.user_attributes.code = this.apprentice.code

          for(var j = 0;j<this.removed_marked_lessons.length; j++){
            this.condiltional_helping_bool = true
            for(var i = 0;i<this.values.length; i++){
              if(this.removed_marked_lessons[j].id == this.values[i].id){
                this.valueIds_to_be_deleted.push(this.values[i].id)
                this.condiltional_helping_bool = false
              }
            };
            if(this.condiltional_helping_bool){
              this.removed_ids_to_be_deleted.push(this.removed_marked_lessons[j].id)
            }
          };


          for(var i=0; i < this.valueIds_to_be_deleted.length; i++){
            this.values.splice(this.values.indexOf(this.values.find(
              v => v.id == this.valueIds_to_be_deleted[i]
            )))
          };

          for(var i=0; i < this.removed_ids_to_be_deleted.length; i++){
            this.removed_marked_lessons.splice(this.removed_marked_lessons.indexOf(
              this.removed_marked_lessons.find(
              v => v.id == this.removed_ids_to_be_deleted[i]
            )))
          };


          for(var i=0; i<this.removed_marked_lessons.length; i++){
            this.student.stusons_attributes.push({
              lesson: this.removed_marked_lessons[i].id, mark: this.removed_marked_lessons[i].mark
            })
          };

          for(var i = 0; i<this.fieldnames.length; i++ ){
            this.student.stusons_attributes.push(
              {lesson: this.fieldnames[i].id, mark: this.fieldnames[i].mark}
            )
          };

          for(var i = 0; i<this.values.length; i++ ){
            this.student.stusons_attributes.push(
              {lesson: this.values[i].id, mark: ''}
            )
          };



    /////////////////////////////////////////////////////////////////////////////
          // for(var i=0; i<this.student_included_id.length; i++){
          //   this.axios.delete('/stusons/' + this.student_included_id[i])
          //   .then((response) => {
          //   })
          // };

          this.axios.delete('/stusons/' + this.student_ID)
            .then((response) => {
            })
    /////////////////////////////////////////////////////////////////////////////



          this.axios.patch('/students/' + this.id, {student: this.student})
          .then( response => {
            alert("student was updated!")
            location.reload()
          })
        }
        else{
          alert("please fill in the Fields")
        }
       })
    },


    remove_selected_lesson(hashid){
      this.removed_marked_lessons.push(this.fieldnames.find(
        f => f.id == hashid
      ))

      this.fieldnames.splice(this.fieldnames.indexOf(this.fieldnames.find(
        f => f.id == hashid
      )), 1)
      this.Multiselect_source.push(this.lessons.find(
        l => l.id == hashid
      ))
    }
  },





  cancel(){
      this.$router.push({ name: 'interns'})
    },
  created(){
    this.axios.get('/students/' + this.id)
    .then(response => {
      this.apprentice.birthPlace = response.data.data.attributes.birthPlace
      this.apprentice.rank = response.data.data.attributes.rank
      this.apprentice.userId = response.data.included[0].id
      this.apprentice.frst_name = response.data.included[0].attributes.frst_name
      this.apprentice.last_name = response.data.included[0].attributes.last_name
      this.apprentice.email = response.data.included[0].attributes.email
      this.apprentice.code = response.data.included[0].attributes.code
      this.student_ID = response.data.data.id
      for(var i = 1; i < response.data.included.length; i++){
        this.student_lessons.push(response.data.included[i])
        this.student_included_id.push(response.data.included[i].id)
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
    })

  }
}
</script>