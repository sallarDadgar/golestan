<template>
  <div>
    <router-link to="/add-teachers">
      <el-button class="addteacher">
        Add new Professor
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
        prop="college"
        label="college"
        width="120">
      </el-table-column>
      <el-table-column
        prop="experience"
        label="experience"
        width="120">
      </el-table-column>
      <el-table-column
        fixed="right"
        label="Operations"
        width="200">
        <template slot-scope="scope">
          <!-- <router-link :to="{name: 'editteachers', params: {professor: scope.row}}"> -->
            <el-button @click="editprof(scope.row.id)">
              <i class="fas fa-edit" title="edit"></i>
            </el-button> |
          <el-button v-on:click="removeProf(scope.row.id)"
            onClick="return confirm('are you sure you want to delete this professor?');">
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
      profs: [],
      users: []
    }
  },
  methods: {
    removeProf(id) {
      this.axios.delete('/profs/' + id)
      .then((response) => {
        location.reload()
      })
    },
    editprof(teacherId){
      this.$router.push({name: 'editprof', params: {profId: teacherId}})
    }
  },
  created() {
    this.axios.get('/profs')
    .then(response => {
      this.profs = response.data
      this.users = deserialize(this.profs);
    })
  }
}
</script>
<style>
.addteacher {
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