<template>
  <el-form ref="form"  label-width="120px">

    <h3>Edit Professor</h3>

    <el-form-item label="first name" prop="firstname">
      <el-input v-model="prof.user_attributes.frst_name">
      </el-input>
    </el-form-item>

    <el-form-item label="last name" prop="lastname">
      <el-input v-model="prof.user_attributes.last_name">
      </el-input>
    </el-form-item>

    <el-form-item label="ID" prop="code">
      <el-input v-model="prof.user_attributes.code">
      </el-input>
    </el-form-item>

    <el-form-item label="email" prop="email">
      <el-input v-model="prof.user_attributes.email">
      </el-input>
    </el-form-item>

    <!-- <el-form-item label="password" prop="password">
      <el-input v-model="prof.user_attributes.password">
      </el-input>
    </el-form-item>

    <el-form-item label="password confirmation" prop="password_confirmation">
      <el-input v-model="prof.user_attributes.password_confirmation">
      </el-input>
    </el-form-item> -->

     <el-form-item label="experience" prop="experience">
      <el-input v-model="prof.experience"></el-input>
    </el-form-item>

    <el-form-item label="college">
      <el-input v-model="prof.college"></el-input>
    </el-form-item>


    <el-form-item>
      <el-button type="primary" @click="updateprof()">Update</el-button>
      <el-button @click="cancel()">Cancel</el-button>
    </el-form-item>

  </el-form>
</template>
<script>
// var deserialize = require('jsonapi-deserializer').deserialize;
export default {
  props: {
    profId: {
      type: String,
      required: true,
    }
  },
  data() {
    return {
      prof: {
        college: "",
        experience: "",
        user_attributes: {
                id: "",
                profile: "my picture",
                frst_name: "",
                last_name: "",
                email: "",
                code: "",
              }
      },
    }
  },
  created() {
    this.axios.get('/profs/' + this.profId)
      .then((response) => {
        this.prof.college = response.data.data.attributes.college
        this.prof.experience = response.data.data.attributes.experience
        this.prof.user_attributes.id = response.data.included[0].id
        this.prof.user_attributes.frst_name = response.data.included[0].attributes.frst_name
        this.prof.user_attributes.last_name = response.data.included[0].attributes.last_name
        this.prof.user_attributes.email = response.data.included[0].attributes.email
        this.prof.user_attributes.code = response.data.included[0].attributes.code
      })

  },
  methods: {
    cancel(){
      this.$router.push({ name: 'teachers'})
    },
    updateprof() {
      this.axios.patch('/profs/' + this.profId, { prof: this.prof })
      .then((response) => {
        alert("professor's info was updated!")
        location.reload()
      })
    }
  }
}
</script>