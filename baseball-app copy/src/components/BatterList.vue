<!-- src/components/BatterList.vue -->
<template>
    <div>
      <h1>Batter List</h1>
  
      <form @submit.prevent="fetchBatters">
        <label for="team">Team (city):</label>
        <input v-model="team" type="text" id="team" />
  
        <label for="last_name">Last Name:</label>
        <input v-model="last_name" type="text" id="last_name" />
  
        <label for="obp">Minimum OBP:</label>
        <input v-model="obp" type="text" id="obp" />
  
        <label for="min_pas">Minimum Plate Appearances:</label>
        <input v-model="min_pas" type="number" id="min_pas" />
  
        <label for="attr">Sort By:</label>
        <select v-model="attr" id="attr">
          <option value="">Any</option>
          <option value="ba">Batting Average</option>
          <option value="obp">On-Base Percentage</option>
          <option value="slg">Slugging Percentage</option>
          <option value="hr">Home Runs</option>
          <option value="bb">Walks</option>
        </select>
  
        <button type="submit">Search Batters</button>
      </form>
  
      <table>
        <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Team</th>
            <th>G</th>
            <th>PA</th>
            <th>AB</th>
            <th>R</th>
            <th>H</th>
            <th>2B</th>
            <th>3B</th>
            <th>HR</th>
            <th>RBI</th>
            <th>BB</th>
            <th>IBB</th>
            <th>SO</th>
            <th>HBP</th>
            <th>SH</th>
            <th>SF</th>
            <th>GDP</th>
            <th>SB</th>
            <th>CS</th>
            <th>BA</th>
            <th>OBP</th>
            <th>SLG</th>
            <th>OPS</th>
            <th>mlbID</th>
          </tr>
        </thead>
        <tbody>
            <tr v-for="batter in batters" :key="batter['mlbid']">
            <td>{{ batter['first_name'] }}</td>
            <td>{{ batter['last_name'] }}</td>
            <td>{{ batter['age'] }}</td>
            <td>{{ batter['team'] }}</td>
            <td>{{ batter['g'] }}</td>
            <td>{{ batter['pa'] }}</td>
            <td>{{ batter['ab'] }}</td>
            <td>{{ batter['r'] }}</td>
            <td>{{ batter['h'] }}</td>
            <td>{{ batter['twob'] }}</td>
            <td>{{ batter['threeb'] }}</td>
            <td>{{ batter['hr'] }}</td>
            <td>{{ batter['rbi'] }}</td>
            <td>{{ batter['bb'] }}</td>
            <td>{{ batter['ibb'] }}</td>
            <td>{{ batter['so'] }}</td>
            <td>{{ batter['hbp'] }}</td>
            <td>{{ batter['sh'] }}</td>
            <td>{{ batter['sf'] }}</td>
            <td>{{ batter['gdp'] }}</td>
            <td>{{ batter['sb'] }}</td>
            <td>{{ batter['cs'] }}</td>
            <td>{{ batter['ba'] }}</td>
            <td>{{ batter['obp'] }}</td>
            <td>{{ batter['slg'] }}</td>
            <td>{{ batter['ops'] }}</td>
            <td>{{ batter['mlbid'] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import axios from 'axios';
  
  export default defineComponent({
    name: 'BatterList',
    data() {
      return {
        team: '',
        last_name: '',
        obp: '',
        min_pas: '',
        attr: '',
        batters: [],
      };
    },
    methods: {
      async fetchBatters() {
        try {
          const response = await axios.get('/batters', {
            params: {
              team: this.team,
              last_name: this.last_name,
            obp: this.obp,
            min_pas: this.min_pas,
            attr: this.attr,
          },
        });
        this.batters = response.data;
      } catch (error) {
        console.error('Error fetching batter data:', error);
      }
    },
  },
});
</script>

<style scoped>
</style>