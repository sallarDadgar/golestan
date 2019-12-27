<template>
  <div>
    <div class="leftside">
      <p>                                                 </p>
    </div>

    <div class="middle">

      <el-form :model="student" ref="student">

        <el-form :inline="true" label-width="120px">
          <el-form-item label="First Name">
            <el-input v-model="student.user.frst_name" disabled="true">
            </el-input>
          </el-form-item>
        </el-form>

        <el-form :inline="true" label-width="120px">
          <el-form-item label="Last Name">
            <el-input v-model="student.user.last_name" disabled="true">
            </el-input>
          </el-form-item>
        </el-form>

        <el-form :inline="true" label-width="120px">
          <el-form-item label="ID">
            <el-input v-model="student.user.code" disabled="true">
            </el-input>
          </el-form-item>
        </el-form>

        <el-form :inline="true" label-width="120px">
          <el-form-item label="Mark">
            <el-input v-model="theMark">
            </el-input>
          </el-form-item>
        </el-form>

        <el-button type="primary" @click="save()">save</el-button>

      </el-form>
    </div>

    <div class="rightside">
    </div>


  </div>
</template>

<script>
import store from '../store/index'
var deserialize = require('jsonapi-deserializer').deserialize;

export default {
  data() {
    return {
      shownDate: [],
      student: [],
      theMark: "",
      input: "<el-input v-model='this.theMark'></el-input>"
    }
  },
  computed:{
    get_studentID() {
      return store.getters.get_student_id
    }
  },
  props: {
    id: {
      type: Number,
      required: true,
    }
  },
  methods: {
    save() {
      // console.log(this.theMark)
      this.axios.patch('/stusons/'+ this.id, {
          id: this.id,
          mark: this.theMark
      })
      location.reload()
    }
  },
  created() {
    this.axios.get('/stusons/'+this.id)
    .then(response => {
      this.theMark = response.data.data.attributes.mark
    })

    this.axios.get('/students/'+this.get_studentID)
    .then(response => {
      this.student = deserialize(response.data)

      this.shownDate.push( {title: "First Name", data: this.student.user.frst_name},
      {title: "Last Name", data: this.student.user.last_name},
      {title: "ID", data: this.student.user.code},
      {title: "Mark", data: this.input} )

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
