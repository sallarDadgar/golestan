<template>
  <div id="app">
    <Header />
    <div class="maindiv" id="app2">
      <router-view />
    </div>
  </div>
</template>

<script>
  import Header from "../components/header.vue"

  export default {
    data () {
      return {
        message: "Hello Vue"
      }
    },
    components: {
      Header,
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
