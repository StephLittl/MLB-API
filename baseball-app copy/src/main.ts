import { createApp } from 'vue';
import App from './App.vue';
import axios from 'axios';

// Set the base URL for Axios
axios.defaults.baseURL = 'http://localhost:8080';

createApp(App).mount('#app');