<template>
  <div>

    <div class="leftside">
      <p>                                                 </p>
    </div>


    <div class="middle">
      <el-table
        :data="lessons"
        style="width: 520px"
        height="500"
        align="center">
        <el-table-column
          prop="title"
          label="title"
          width="150">
        </el-table-column>

        <el-table-column
          prop="unit"
          label="unit"
          width="70">
        </el-table-column>

        <el-table-column
          fixed="right"
          label="Operations"
          width="250">
          <template slot-scope="scope">
            <el-button @click="showinput(scope.row.id)">
              <i class="fas fa-tv" title="show"></i>
            </el-button> |
            <el-button >
              <i class="fas fa-edit" title="edit"></i>
            </el-button> |
            <el-button >
              <i class="fas fa-trash-alt" title="delete">
              </i>
              </el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>


    <div class="rightside">
      <div v-if="conditionalshow">
        <br/><br/><br/><br/>
        Title: {{fieldname.title}}<br/>
        Unit: {{fieldname.unit}}<br/>
        Professor: {{profname.user.frst_name}} {{profname.user.last_name}}<br/>
        Major: {{majorname.attributes.title}}<br/>
      </div>
    </div>

  </div>
</template>
<script>
import axios from 'axios';
var deserialize = require('jsonapi-deserializer').deserialize;

export default {
  data(){
    return {
      fileds: [],
      lessons: [],
      profs: [],
      users: [],
      majors: [],
      conditionalshow: false,
      fieldID: 0,
      majorID: 0,
      userID: 0,
      fieldname: "",
      fieldunit: "",
      profID: 0,
      profname: "",
      majorname: ""
    }
  },
  methods: {
    showinput(lessonid) {
      this.conditionalshow = true
      this.fieldID = lessonid
      this.fieldname = this.lessons.find(l => l.id == this.fieldID)
      this.majorID = this.fieldname.fkey_id
      this.majorname = this.majors.find(m => m.id == this.majorID)
      this.profID = this.fieldname.projor.prof
      this.profname = this.users.find(u => u.id == this.profID)
      // console.log(this.fieldname)
    }
  },
  created() {
    this.axios.get('/fields')
    .then(response => {
      this.fileds = response.data
      this.lessons = deserialize(this.fileds)
      // console.log(this.lessons)
    })

    this.axios.get('/profs')
    .then(response => {
      this.profs = response.data
      this.users = deserialize(this.profs);
      // console.log(this.users)
    })

    this.axios.get('/reshtehs')
    .then(response => {
      this.majors = response.data.data
      // console.log(this.majors)
    })
  }
}
</script>
<style>
.middle{
  float: left;
  width: 45%;
  height: 100%;
}
.rightside{
  float: right;
  width: 35%;
  height: 100%;
}
.leftside{
  float: left;
  width: 20%;
  height: 100%;
}
.textsize{
  font-size: 20px;
}
</style>
