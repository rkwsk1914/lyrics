import Vue from 'vue'

document.addEventListener('turbolinks:load', () => {
 console.log('OK');
  const el = document.getElementById('vue-app')
  if (el) {
    new Vue({
      el: el,
      data() {
        return {
          message: 'Hello Vue!'
        }
      }
    })
  }
})