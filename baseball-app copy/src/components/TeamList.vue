<!-- src/components/TeamList.vue -->
<template>
    <div>
      <h1>Team List</h1>
  
      <form @submit.prevent="fetchTeams">
        <label for="name">Team Name (3 letter abbreviation):</label>
        <input v-model="name" type="text" id="name" />
  
        <label for="attr">Sort By:</label>
        <select v-model="attr" id="attr">
          <option value="">Any</option>
          <option value="hr">Home Runs</option>
          <option value="r">Runs</option>
          <option value="bb">Walks</option>
          <option value="age">Age</option>
        </select>
  
        <button type="submit">Search Teams</button>
      </form>
  
      <table>
        <thead>
          <tr>
            <th>Team ID</th>
            <th>Team Name</th>
            <th>Age</th>
            <th>AB</th>
            <th>PA</th>
            <th>H</th>
            <th>HR</th>
            <th>R</th>
            <th>RBI</th>
            <th>BB</th>
            <th>IBB</th>
            <th>SO</th>
            <th>HBP</th>
            <th>SF</th>
            <th>SH</th>
            <th>GDP</th>
            <th>SB</th>
            <th>CS</th>
            <th>AVG</th>
            <th>BB%</th>
            <th>K%</th>
            <th>OBP</th>
            <th>SLG</th>
            <th>OPS</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="team in teams" :key="team['team_id']">
            <td>{{ team['team_id'] }}</td>
            <td>{{ team['team'] }}</td>
            <td>{{ team['age'] }}</td>
            <td>{{ team['ab'] }}</td>
            <td>{{ team['pa'] }}</td>
            <td>{{ team['h'] }}</td>
            <td>{{ team['hr'] }}</td>
            <td>{{ team['r'] }}</td>
            <td>{{ team['rbi'] }}</td>
            <td>{{ team['bb'] }}</td>
            <td>{{ team['ibb'] }}</td>
            <td>{{ team['so'] }}</td>
            <td>{{ team['hbp'] }}</td>
            <td>{{ team['sf'] }}</td>
            <td>{{ team['sh'] }}</td>
            <td>{{ team['gdp'] }}</td>
            <td>{{ team['sb'] }}</td>
            <td>{{ team['cs'] }}</td>
            <td>{{ team['avg'] }}</td>
            <td>{{ team['bbpct'] }}</td>
            <td>{{ team['kpct'] }}</td>
            <td>{{ team['obp'] }}</td>
            <td>{{ team['slg'] }}</td>
            <td>{{ team['ops'] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import axios from 'axios';
  
  export default defineComponent({
    name: 'TeamList',
    data() {
      return {
        name: '',
        attr: '',
        teams: [],
      };
    },
    methods: {
      async fetchTeams() {
        try {
          const response = await axios.get('/teams', {
            params: {
              name: this.name,
              attr: this.attr,
            },
          });
          this.teams = response.data;
        } catch (error) {
          console.error('Error fetching team data:', error);
        }
      },
    },
  });
  </script>
  
  <style scoped>
  </style>
  