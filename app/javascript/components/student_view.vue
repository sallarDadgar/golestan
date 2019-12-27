<template>
  <div>
    <div class="leftside">
      <p>                                                 </p>
    </div>

    <div class="middle">
      <el-table
        :data="shownData"
        style="width: 100%"
        height="450">

          <el-table-column
            prop="name"
            label="title"
            width="150">
          </el-table-column>

          <el-table-column
            prop="professor"
            label="professor"
            width="150">
          </el-table-column>

          <el-table-column
            prop="mark"
            label="mark"
            width="110">
          </el-table-column>

      </el-table>
    </div>

    <div class="rightside">
    </div>

  </div>
</template>

<script>
import store from '../store/index'
import axios from 'axios';
var deserialize = require('jsonapi-deserializer').deserialize;


export default {
  computed: {
    get_user() {
      return store.getters.get_user
    }
  },
  data(){
    return {
      lessons: [],
      users: [],
      stusons: [],
      students_stusons: [],
      students_lessons: [],
      students_professors: [],
      shownData: [],
    }
  },
  created(){
    this.axios.get('/stusons')
    .then(response => {
      this.stusons = response.data.data
      for(var i = 0; i<this.stusons.length; i++){
        if(this.stusons[i].attributes.fk_id == this.get_user.fkey_id){
          this.students_stusons.push(this.stusons[i])
        }
      }
      this.axios.get('/fields')
      .then(response => {
        this.lessons = deserialize(response.data)
        for(var i = 0; i<this.lessons.length; i++){
          for(var j = 0; j<this.students_stusons.length; j++){
            if(this.lessons[i].id == this.students_stusons[j].attributes.lesson){
              this.students_lessons.push({field: this.lessons[i],
              mark: this.students_stusons[j].attributes.mark})
            }
          }
        }

        this.axios.get('/profs')
        .then(response => {
          this.users = deserialize(response.data);
          for(var i = 0; i<this.students_lessons.length; i++){
            for(var j = 0; j<this.users.length; j++){
              if(this.students_lessons[i].field.projor.prof == this.users[j].id){
                this.shownData.push({name: this.students_lessons[i].field.title,
                professor: this.users[j].user.frst_name + " " + this.users[j].user.last_name,
                mark: this.students_lessons[i].mark})
              }
            }
          }
        })
      })
    })
  }
}
</script>

<style>
.middle{
  float: left;
  width: 40%;
  height: 100%;
}
.rightside{
  float: right;
  width: 30%;
  height: 100%;
}
.leftside{
  float: left;
  width: 30%;
  height: 100%;
}
</style>
