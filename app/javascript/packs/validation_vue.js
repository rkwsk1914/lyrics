/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

import Vue from 'vue'
import App from '../app.vue'


const blankCheckpForm = (element, valid) => {
  let msg = '';
  
  if(element.val() != ''){
    element.removeClass('is-invalid');
    element.addClass('is-valid');
    valid.removeClass('invalid-feedback');
    valid.addClass('valid-feedback');
    valid.removeClass('d-none');
    msg = 'OK';
  }
  else{
    element.removeClass('is-valid');
    element.addClass('is-invalid');
    valid.removeClass('valid-feedback');
    valid.addClass('invalid-feedback');
    valid.removeClass('d-none');
    msg = 'NO';
  }
  return msg;
};

document.addEventListener('DOMContentLoaded', () => {

  const username = Vue.component('user-name', {
  data() {
    return { 
      name: '',
      msg: '',
    };
  },
  computed:{
    changeName() {
      console.log(this.name);
      $('#user_name').val(this.name);
      return '';
    },
  },
  methods: {
    valiName(e) {
      let element = $(e.target);
      let valid = $('.name-valid');
      this.msg = blankCheckpForm(element,valid);
    },
  },
  template: `
    <div class="form-group row">
      <div class="col-sm-2">
        <label class="col-form-label" >Name</label>
      </div>
      <div class="col-sm-10">
        <input class="form-control" placeholder="Your Name" type="text" v-model="name" v-on:blur="valiName" maxlength="20">
        <div class="d-none name-valid">
          {{ msg }}
        </div>
        {{ changeName }}
      </div>
    </div>
  `,
});
  const usernemail = Vue.component('user-email',{
  data() {
    return { 
      email: '',
      msg: ''
    };
  },
  computed:{
    changeEmail() {
      console.log(this.email);
      $('#user_email').val(this.email);
      return '';
    },
  },
  methods: {
    valiEmail(e) {
      let element = $(e.target);
      let valid = $('.email-valid');
      this.msg = blankCheckpForm(element,valid);
    },
  },
  template: `
    <div class="form-group row">
      <div class="col-sm-2">
        <label class="col-form-label" >Email</label>
      </div>
      <div class="col-sm-10">
        <input class="form-control" placeholder="example@exam.com" type="email" v-model="email" v-on:blur="valiEmail" maxlength="255">
        <div class="d-none email-valid">
          {{ msg }}
        </div>
        {{ changeEmail }}
      </div>
    </div>
  `,
  });
  const userpassword = Vue.component('user-password',{
  data() {
    return { 
      password: '',
      msg: '',
    };
  },
  computed:{
    changePassword() {
      if(this.password.length >= 8){
        $(".pas").removeClass('is-invalid');
        $(".pas").addClass('is-valid');
        $('.password-valid').removeClass('invalid-feedback');
        $('.password-valid').addClass('valid-feedback');
        $('.password-valid').removeClass('d-none');
        this.msg ="Clear!";
      }
      else if($('.password-valid').hasClass('d-none') === false){
        let count = String(8 - this.password.length);
        this.msg = 'あと' + count + '文字';
      } 
      
      $('#user_password').val(this.password);
      $('#user_password_confirmation').val(this.password);
      return '';
    },
  },
  methods: {
    valiPassword(e) {
      let element = $(e.target);
      let valid = $('.password-valid');
      let count = String(8 - element.val().length);
      
      if(element.val() != '' && element.val().length < 8){
        element.removeClass('is-valid');
        element.addClass('is-invalid');
        valid.removeClass('valid-feedback');
        valid.addClass('invalid-feedback');
        valid.removeClass('d-none');
        this.msg = 'あと' + count + '文字';
      }
      else{
        this.msg = blankCheckpForm(element,valid); 
      }
    },
  },
  template: `
    <div class="form-group row">
      <div class="col-sm-2">
        <label class="col-form-label" >Password</label>
      </div>
      <div class="col-sm-10">
        <input class="form-control pas" placeholder="8文字以上のパスワード/ password is at least 8 characters." type="password" v-model="password" v-on:blur="valiPassword">
        <div class="d-none password-valid">
          {{ msg }}
        </div>
        {{ changePassword }}
      </div>
    </div>
  `,
  });

  const signupForm = {
    components: {
      'user-name': username,
    },
    template: `
      <div>
        <user-name></user-name>
        <user-email></user-email>
        <user-password></user-password>
      </div>
    `,
  };

  const app = new Vue({
    el: '#signup_form',
    components: {
    'signup-form': signupForm,
    },
  })

})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks'
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: () => {
//       return {
//         message: "Can you say hello?"
//       }
//     },
//     components: { App }
//   })
// })
