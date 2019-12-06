<template>
  <div id="auth">
    <home />
  </div>
</template>

<script>
import home from "../components/home.vue"
export default {
  data () {
    return {
      authenticated: false,
      message: "Hello Vue"
    }
  },
  components: {
    home
  }
}
</script>