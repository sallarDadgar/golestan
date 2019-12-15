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
            <el-button @click="showinfo(scope.row.id)">
              <i class="fas fa-tv" title="show"></i>
            </el-button> |
            <el-button @click="showeditinput(scope.row.id, scope.row.title, scope.row.unit)">
              <i class="fas fa-edit" title="edit"></i>
            </el-button> |
            <el-button>
              <i class="fas fa-trash-alt" title="delete">
              </i>
              </el-button>
          </template>
        </el-table-column>
      </el-table>
      <br/>
      <br/>
      <el-button class="addteacher" @click="showAddInput()">
        Add new lesson
      </el-button>
    </div>


    <div class="rightside">

      <div v-if="conditionalBoolshow">
        <br/><br/><br/><br/>
        Title: {{fieldname.title}}<br/>
        Unit: {{fieldname.unit}}<br/>
        Professor: {{profname.user.frst_name}} {{profname.user.last_name}}<br/>
        Major: {{majorname.attributes.title}}<br/>
      </div>

      <div v-if="conditionalBooladd">
        <br/><br/><br/><br/>
        <p class="textsize"> Please enter a title for the new Lesson</p>
        <el-input v-model="field.title"></el-input>
        <br/>
        <p class="textsize"> Please enter number of units for the new Lesson</p>
        <el-input v-model="field.unit"></el-input>
        <br/>
        <p class="textsize"> Please choose the major of the new Lesson</p>
        <select @change="switchViewMajor($event, $event.target.selectedIndex)">
          <option v-for="(majorname) in majornames" v-bind:value="majorname" v-bind:key="majorname">
            {{ majorname }}
          </option>
        </select>
        <br/>
        <p class="textsize"> Please choose the Professor of the new Lesson</p>
        <select @change="switchViewProf($event, $event.target.selectedIndex)">
          <option v-for="(profname) in profnames" v-bind:value="profname" v-bind:key="profname">
            {{ profname }}
          </option>
        </select>
        <br/>
        <br/>
        <br/>
        <el-button @click="savefield()">
        save
        </el-button>
        <el-button @click="cancelbutton()">
        cancel
        </el-button>
      </div>

      <div v-if="conditionalBooledit">
        <br/><br/><br/><br/>
        <p class="textsize"> Please enter a new title for the Lesson</p>
        <el-input v-model="field.title"></el-input>
        <br/>
        <p class="textsize"> Please enter a new number of units for the Lesson</p>
        <el-input v-model="field.unit"></el-input>
        <br/>
        <p class="textsize"> Please choose a new major of the Lesson</p>
        <select @change="switchViewMajor($event, $event.target.selectedIndex)">
          <option v-for="(majorname) in majornames" v-bind:value="majorname" v-bind:key="majorname">
            {{ majorname }}
          </option>
        </select>
        <br/>
        <p class="textsize"> Please choose a new Professor of the Lesson</p>
        <select @change="switchViewProf($event, $event.target.selectedIndex)">
          <option v-for="(profname) in profnames" v-bind:value="profname" v-bind:key="profname">
            {{ profname }}
          </option>
        </select>
        <br/>
        <br/>
        <br/>
        <el-button @click="updatefield()">
        update
        </el-button>
        <el-button @click="cancelbutton()">
        cancel
        </el-button>
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
      field: {
        title: "",
        unit:"",
        fkey_type: 'Reshteh',
        fkey_id: 0,
        projor_attributes: {
          prof: 0
        }
      },
      fieldIdEdited: 0,
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
      majorname: "",
      majornames: [],
      majorIds: [],
      profnames: [],
      profIds: [],
      selectedindexformajor: 0,
      selectedtitleformajor: "",
      selectedindexforprof: 0,
      selectedtitleforprof: "",
      conditionalBoolshow: false,
      conditionalBooledit: false,
      conditionalBooladd: false
    }
  },
  methods: {
    updatefield(){
      this.field.fkey_id = Number(this.selectedindexformajor)
      this.field.projor_attributes.prof = Number(this.selectedindexforprof)
      this.axios.patch('/fields/' + this.fieldIdEdited, this.field)
      .then((response) => {
        alert("Lesson was updated!")
        location.reload()
      })
    },
    showeditinput(id, title, unit){
      this.conditionalBooledit = true
      this.conditionalBoolshow = false
      this.conditionalBooladd = false
      this.fieldIdEdited = id
      this.field.title = title
      this.field.unit = unit
    },
    savefield(){
      this.field.fkey_id = Number(this.selectedindexformajor)
      this.field.projor_attributes.prof = Number(this.selectedindexforprof)
      this.axios.post('/fields', this.field )
      .then((response) => {
        if(response.status == 200 && response.statusText == "OK"){
          alert("Field was created!")
          location.reload()
        }
        else
          alert("Field was not created!")
        // console.log(response)
      })
      // console.log(this.field.projor_attributes.prof)
    },
    cancelbutton(){
      this.field.title = ""
      this.field.unit = ""
      this.conditionalBooladd = false
      this.conditionalBoolshow = false
      this.conditionalBooledit = false
    },
    showinfo(lessonid) {
      this.conditionalBoolshow = true
      this.conditionalBooledit = false
      this.conditionalBooladd = false
      this.fieldID = lessonid
      this.fieldname = this.lessons.find(l => l.id == this.fieldID)
      this.majorID = this.fieldname.fkey_id
      this.majorname = this.majors.find(m => m.id == this.majorID)
      this.profID = this.fieldname.projor.prof
      this.profname = this.users.find(u => u.id == this.profID)
      // console.log(this.fieldname)
    },
    switchViewMajor(event, selectedIndex){
      this.selectedindexformajor = this.majorIds[selectedIndex]
    },
    switchViewProf(event, selectedIndex){
      this.selectedindexforprof = this.profIds[selectedIndex]
      // console.log(this.selectedindexforprof)
    },
    showAddInput(){
      this.field.title = ""
      this.field.unit = ""
      this.conditionalBooladd = true
      this.conditionalBoolshow = false
      this.conditionalBooledit = false
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
      for(var i = 0; i < this.users.length; i++){
        this.profnames.push(this.users[i].user.frst_name + " " + this.users[i].user.last_name)
        this.profIds.push(this.users[i].id)
      };
      this.selectedindexforprof = this.profIds[0]
      // console.log(this.selectedindexforprof)
    })

    this.axios.get('/reshtehs')
    .then(response => {
      this.majors = response.data.data
      for(var i = 0; i < this.majors.length; i++){
        this.majornames.push(this.majors[i].attributes.title)
        this.majorIds.push(this.majors[i].id)
      };
      this.selectedindexformajor = this.majorIds[0]
      // console.log(this.majornames)
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
  font-size: 13px;
}
</style>
