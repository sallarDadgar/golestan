<template>
<div>
    <el-table
      :data="studentsfortable"
      style="width: 80%"
      height="450">
        <el-table-column
          prop="frst_name"
          label="first name"
          width="150">
        </el-table-column>
        <el-table-column
          prop="last_name"
          label="last name"
          width="150">
        </el-table-column>
        <el-table-column
          prop="code"
          label="ID"
          width="150">
        </el-table-column>
        <el-table-column
          prop="mark"
          label="Mark"
          width="150">
        </el-table-column>

        <el-table-column
        fixed="right"
        label="Operations"
        width="200">
        <template slot-scope="scope">
            <el-button @click="editmark(scope.row.stusonid, scope.row.studentid)">
              <i class="fas fa-edit" title="edit"></i>
            </el-button>
        </template>
      </el-table-column>


    </el-table>
</div>
</template>
<script>
import axios from 'axios';
import store from '../store/index'
import { stringify } from 'querystring';

export default {
  data(){
    return {
      all_stusons: [],
      thisLessonsStusons: [],
      all_users: [],
      all_students: [],
      thisLessonsInterns: [],
      studentsfortable: []
    }
  },
  props: {
    id: {
      type: String,
      required: true,
    }
  },
  watch:{
    id(newValue){
      this.all_stusons = []
      this.thisLessonsStusons = []
      this.all_users = []
      this.all_students = []
      this.thisLessonsInterns = []
      this.studentsfortable = []
      this.fetchData()
      this.$forceUpdate()
    }
  },
  computed: {
    getting_stusons() {
      return store.getters.get_stusons
    }
  },
  methods: {

    editmark(stusonid, studentid) {
      store.dispatch('initiateStudentID', studentid)
      this.$router.push( {name: 'EditMark', params: {id: stusonid} } )
    },



    fetchData() {
      this.axios.get('/users')
      .then(response => {
        this.all_users = response.data.data
        for(var i = 0; i<this.all_users.length; i++){
          if(this.all_users[i].attributes.role == "student")
            this.all_students.push(this.all_users[i])
        }

        this.all_stusons = this.getting_stusons

        for(var i = 0; i<this.all_stusons.length; i++){
          if(this.all_stusons[i].attributes.lesson == this.id){
            this.thisLessonsStusons.push(this.all_stusons[i])
          }
        }

        for(var i = 0; i<this.all_students.length; i++){
          for(var j = 0; j<this.thisLessonsStusons.length; j++){
            if(this.all_students[i].attributes.fkey_id ==
            this.thisLessonsStusons[j].attributes.fk_id){
              this.thisLessonsInterns.push(this.all_students[i])
              this.studentsfortable.push({
                studentid: this.all_students[i].attributes.fkey_id,
                frst_name: this.all_students[i].attributes.frst_name,
                last_name: this.all_students[i].attributes.last_name,
                code: this.all_students[i].attributes.code,
                stusonid: this.thisLessonsStusons[j].attributes.id,
                mark: this.thisLessonsStusons[j].attributes.mark
              })
            }
          }
        }
        // console.log('all_stusons', this.all_stusons)
      })
    }
  },

  created () {
    this.fetchData()
  }
}
</script>