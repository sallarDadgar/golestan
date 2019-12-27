<template>
  <div id="app">
    <Header />
    <div class="maindiv" id="app2">
      <studentInfo />
    </div>
  </div>
</template>

<script>
  import Header from "../components/student_header.vue"
  import studentInfo from "../components/student_view.vue"

  export default {
    data () {
      return {
        message: "Hello Vue"
      }
    },
    components: {
      Header,
      studentInfo
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
