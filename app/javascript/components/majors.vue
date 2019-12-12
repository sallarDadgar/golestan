<template>
  <div>

    <div class="leftside">
      <p>                                                 </p>
    </div>


    <div class="middle">
      <el-table
        :data="majors"
        style="width: 350px"
        height="300"
        align="center">
        <el-table-column
          prop="attributes.title"
          label="title"
          width="150">
        </el-table-column>

        <el-table-column
          fixed="right"
          label="Operations"
          width="200">
          <template slot-scope="scope">
            <el-button @click="showEditinput(scope.row.id)"
            :disabled="!conditionalBoolEdit && !helpingBool">
              <i class="fas fa-edit" title="edit"></i>
            </el-button> |
            <el-button v-on:click="removemajor(scope.row.id)"
            onClick="return confirm('are you sure you want to delete this professor?');">
              <i class="fas fa-trash-alt" title="delete">
              </i>
              </el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-button v-if="conditionalBoolAdd && helpingBool" @click="showAddinput()">
        Add new major
      </el-button>

      <div v-if="conditionalBoolAdd && !helpingBool">
        <el-input v-model="title"></el-input>
        <p class="textsize">Please enter the title for the new Major</p>
        <el-button @click="savemajor()">
        Save
        </el-button>
        <el-button @click="cancelAddbutton()">
        cancel
        </el-button>
      </div>



      <div v-if="conditionalBoolEdit && !helpingBool">
        <el-input v-model="newTitle"></el-input>
        <p class="textsize">Please enter the new title for the chosen Major</p>
        <el-button @click="updatemajor()">
        update
        </el-button>
        <el-button @click="cancelEditbutton()">
        cancel
        </el-button>
      </div>


    </div>


    <div class="rightside">
    </div>

  </div>
</template>
<script>
import axios from 'axios';

// var deserialize = require('jsonapi-deserializer').deserialize;
export default {
  data() {
    return {
      title: "",
      newTitle: "",
      conditionalBoolAdd: true,
      conditionalBoolEdit: true,
      helpingBool: true,
      majorIDedited: 0,
      majors: []
    }
  },
  methods: {
    cancelAddbutton(){
      this.title = ""
      this.helpingBool = true
      this.conditionalBoolEdit = true
    },
    cancelEditbutton(){
      this.helpingBool = true
      this.conditionalBoolAdd = true
    },
    showAddinput(){
      this.helpingBool = false
      this.conditionalBoolEdit = false
    },
    savemajor(){
      this.axios.post('/reshtehs', { title: this.title })
      .then((Response) => {
        location.reload()
      })
    },
    removemajor(id){
      this.axios.delete('/reshtehs/' + id)
      .then((response) => {
        // console.log(response)
        location.reload()
      })
    },
    updatemajor(){
      this.axios.patch('/reshtehs/' + this.majorIDedited, { title: this.newTitle })
      .then((response) => {
        location.reload()
        // console.log(response)
      })
    },
    showEditinput(id){
      this.helpingBool = false
      this.majorIDedited = id
      this.conditionalBoolAdd = false

    }
  },
  created() {
    this.axios.get('/reshtehs')
    .then(response => {
      this.majors = response.data.data
      // console.log(this.majors)
      // this.reshtehs = response.data
      // this.majors = deserialize(this.reshtehs);
    })
  }
}
</script>
<style>
.wholepage{
  width: 100%;
  height: 100%;
}
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
.textsize{
  font-size: 20px;
}
</style>
