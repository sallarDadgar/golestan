<template>
<div id="app">
  <div v-if="authenticated">
    <Header />
    <div class="maindiv" id="app2">
      <router-view />
    </div>
  </div>
  <div v-else>
    <Home />
  </div>

  <!-- <div>
    <Home />
  </div> -->



  <!-- <Header />
  <div class="maindiv" id="app2">
    <router-view />
  </div> -->
</div>
</template>

<script>
import Header from "./components/header.vue"
import Home from "./components/home.vue"
export default {
  data: function () {
    return {
      authenticated: false,
      message: "Hello Vue"
    }
  },
  components: {
    Header,
    Home
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
