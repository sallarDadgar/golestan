<template>
<div>
  <div class="leftside">
    <p>                                                 </p>
  </div>
  <div class="middle">
      <h2>
        <i class="fas fa-user-graduate"></i> {{student.user_attributes.frst_name}} {{student.user_attributes.last_name}}
      </h2>
      <p class="innerHeader"><i class="fas fa-info"></i>nfo:</p>
      <ul>
        <li><i class="fas fa-id-badge"></i> Code: {{student.user_attributes.code}}</li>
        <li><i class="fas fa-envelope-square"></i> Email: {{student.user_attributes.email}}</li>
        <li><i class="fas fa-city"></i> Birth Place: {{student.birthPlace}}</li>
        <li><i class="fas fa-level-up-alt"></i> Rank: {{student.rank}}</li>
      </ul>
      <br/>
      <p class="innerHeader">Courses:</p>
      <ul>
        <li v-for="field in fieldnames" v-bind:key="field">
          {{field.course}}:   {{field.mark}}
        </li>
      </ul>
  </div>
  <div class="rightside">
  </div>
</div>
</template>
<script>
export default {
  props: {
    id: {
      type: String,
      required: true,
    }
  },
  data() {
    return {
      fieldnames: [],
      fieldmarks: [],
      student_lessons: [],
      // student_lessons_names: [],
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
      for(var j =0 ; j<response.data.data.length; j++){
        for(var i = 0; i < this.student_lessons.length; i++){
          if(this.student_lessons[i].attributes.lesson == response.data.data[j].id ){
            this.fieldnames.push({course: response.data.data[j].attributes.title, mark: this.student_lessons[i].attributes.mark})
          }
        };
      };
      console.log(this.fieldmarks)
    })
  }
}
</script>
<style>
.innerHeader{
text-align: left;
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
.lessonName{
  width: 40%;
}
.lessonMark{
  width: 40%;
}
</style>