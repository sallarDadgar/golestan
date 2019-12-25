<template>
  <div id="app">
    <TeacherHeader />
    <div class="maindiv" id="app2">
      <router-view />
    </div>
  </div>
</template>

<script>
  import TeacherHeader from "../components/teacher_header.vue"

  export default {
    data () {
      return {
        message: "Hello Vue"
      }
    },
    components: {
      TeacherHeader,
    }
  }
</script>

<style>
  .maindiv {
    width: 80%;
    float: left;
    height: 100%;
    }
  p {
    font-size: 2em;
    text-align: center;
    float: bottom;
  }
</style>
