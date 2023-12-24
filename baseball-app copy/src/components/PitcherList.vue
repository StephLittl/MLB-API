<!-- src/components/PitcherList.vue -->
<template>
    <div>
      <h1>Pitcher List</h1>
  
      <form @submit.prevent="fetchPitchers">
        <label for="team">Team (city):</label>
        <input v-model="team" type="text" id="team" />
  
        <label for="last_name">Last Name:</label>
        <input v-model="last_name" type="text" id="last_name" />
  
        <label for="era">Maximum ERA:</label>
        <input v-model="era" type="text" id="era" />
  
        <label for="min_innings">Minimum Innings Pitched:</label>
        <input v-model="min_innings" type="text" id="min_innings" />
  
        <label for="attr">Sort By:</label>
        <select v-model="attr" id="attr">
          <option value="">Any</option>
          <option value="w">Wins</option>
          <option value="g">Games</option>
          <option value="ip">Innings Pitched</option>
          <option value="whip">WHIP</option>
          <option value="era">ERA</option>
        </select>
  
        <button type="submit">Search Pitchers</button>
      </form>
  
      <table>
        <thead>
          <tr>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Age</th>
            <th>Team</th>
            <th>Games</th>
            <th>Games Started</th>
            <th>Wins</th>
            <th>Losses</th>
            <th>Saves</th>
            <th>Innings Pitched</th>
            <th>Hits</th>
            <th>Runs</th>
            <th>Earned Runs</th>
            <th>Walks</th>
            <th>Strikeouts</th>
            <th>Home Runs Allowed</th>
            <th>Hit By Pitch</th>
            <th>ERA</th>
            <th>At Bats</th>
            <th>2B</th>
            <th>3B</th>
            <th>Intentional Walks</th>
            <th>Ground into Double Play</th>
            <th>Sacrifice Flies</th>
            <th>Stolen Bases</th>
            <th>Caught Stealing</th>
            <th>Pick Offs</th>
            <th>Batters Faced</th>
            <th>Pitches Thrown</th>
            <th>Strikes Thrown</th>
            <th>StL (strike looking)</th>
            <th>StS (strike swinging)</th>
            <th>Line Drives</th>
            <th>Pop Ups</th>
            <th>WHIP</th>
            <th>BAbip</th>
            <th>MLB ID</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="pitcher in pitchers" :key="pitcher['mlbid']">
            <td>{{ pitcher['first_name'] }}</td>
            <td>{{ pitcher['last_name'] }}</td>
            <td>{{ pitcher['age'] }}</td>
            <td>{{ pitcher['team'] }}</td>
            <td>{{ pitcher['g'] }}</td>
            <td>{{ pitcher['gs'] }}</td>
            <td>{{ pitcher['w'] }}</td>
            <td>{{ pitcher['l'] }}</td>
            <td>{{ pitcher['sv'] }}</td>
            <td>{{ pitcher['ip'] }}</td>
            <td>{{ pitcher['h'] }}</td>
            <td>{{ pitcher['r'] }}</td>
            <td>{{ pitcher['er'] }}</td>
            <td>{{ pitcher['bb'] }}</td>
            <td>{{ pitcher['so'] }}</td>
            <td>{{ pitcher['hr'] }}</td>
            <td>{{ pitcher['hbp'] }}</td>
            <td>{{ pitcher['era'] }}</td>
            <td>{{ pitcher['ab'] }}</td>
            <td>{{ pitcher['twob'] }}</td>
            <td>{{ pitcher['threeb'] }}</td>
            <td>{{ pitcher['ibb'] }}</td>
            <td>{{ pitcher['gdp'] }}</td>
            <td>{{ pitcher['sf'] }}</td>
            <td>{{ pitcher['sb'] }}</td>
            <td>{{ pitcher['cs'] }}</td>
            <td>{{ pitcher['po'] }}</td>
            <td>{{ pitcher['bf'] }}</td>
            <td>{{ pitcher['pit'] }}</td>
            <td>{{ pitcher['str'] }}</td>
            <td>{{ pitcher['stl'] }}</td>
            <td>{{ pitcher['sts'] }}</td>
            <td>{{ pitcher['ld'] }}</td>
            <td>{{ pitcher['pu'] }}</td>
            <td>{{ pitcher['whip'] }}</td>
            <td>{{ pitcher['babip'] }}</td>
            <td>{{ pitcher['mlbid'] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import axios from 'axios';
  
  export default defineComponent({
    name: 'PitcherList',
    data() {
      return {
        team: '',
        last_name: '',
        era: '',
        min_innings: '',
        attr: '',
        pitchers: [],
      };
    },
    methods: {
      async fetchPitchers() {
        try {
          const response = await axios.get('/pitchers', {
            params: {
              team: this.team,
              last_name: this.last_name,
              era: this.era,
              min_innings: this.min_innings,
              attr: this.attr,
            },
          });
          this.pitchers = response.data;
        } catch (error) {
          console.error('Error fetching pitcher data:', error);
        }
      },
    },
  });
  </script>
  
  <style scoped>
  </style>
  