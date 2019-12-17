<template>
  <div>
    <router-link to="/add-students">
      <el-button class="addstudent">
        Add new Student
      </el-button>
    </router-link>

    <el-table
      :data="users"
      style="width: 100%"
      height="450">
      <el-table-column
        prop="user.frst_name"
        label="first name"
        width="150">
      </el-table-column>
      <el-table-column
        prop="user.last_name"
        label="last name"
        width="120">
      </el-table-column>
      <el-table-column
        prop="user.code"
        label="ID"
        width="120">
      </el-table-column>
      <el-table-column
        prop="user.email"
        label="email"
        width="300">
      </el-table-column>
      <el-table-column
        prop="birthPlace"
        label="birthPlace"
        width="120">
      </el-table-column>
      <el-table-column
        prop="rank"
        label="rank"
        width="120">
      </el-table-column>
      <el-table-column
        fixed="right"
        label="Operations"
        width="330">
        <template slot-scope="scope">
          <!-- <router-link :to="{name: 'editteachers', params: {professor: scope.row}}"> -->
          <el-button @click="showinfo(scope.row.id)">
            <i class="fas fa-tv" title="show"></i>
          </el-button> |
          <el-button @click="editStudent(scope.row.id)">
            <i class="fas fa-edit" title="edit"></i>
          </el-button> |
          <el-button v-on:click="removestudent(scope.row.id)">
            <i class="fas fa-trash-alt" title="delete">
            </i>
            </el-button>
        </template>
      </el-table-column>
    </el-table>


  </div>
</template>
<script>
import axios from 'axios';

var deserialize = require('jsonapi-deserializer').deserialize;
export default {
  data() {
    return {
      students: [],
      users: []
    }
  },
  methods: {
    removestudent(id) {
      if(confirm("are you sure you want to delete this Student?"))
      this.axios.delete('/students/' + id)
      .then((response) => {
        location.reload()
      })
    },
    showinfo(studentid){
      this.$router.push({name: 'showstudent', params: {id: studentid}})
    },
    editStudent(editid){
      this.$router.push({name: 'editstudent', params: {id: editid}})
    }
  },
  created() {
    this.axios.get('/students')
    .then(response => {
      this.students = response.data
      this.users = deserialize(this.students);
    })
  }
}
</script>
<style>
.addstudent {
  width: 300px;
  height: 40px;
  left: 50px;
  top: 40px;
}
.techers {
  width: 20%;
  float: left;
}
.users {
  height: 100%;
  width: 80%;
  float: right;
}
</style>