
<!-- src/components/GameList.vue -->
<template>
  <div>
    <h1>Game List</h1>

    <form @submit.prevent="fetchGames">
      <label for="team">Team (3 letter abbreviation):</label>
      <input v-model="team" type="text" id="team" />

      <label for="home">Home?:</label>
      <select v-model="home" id="home">
        <option value="">Any</option>
        <option value="true">Home</option>
        <option value="false">Away</option>
      </select>

      <label for="startDate">Start Date:</label>
      <input v-model="startDate" type="date" id="startDate" />

      <label for="endDate">End Date:</label>
      <input v-model="endDate" type="date" id="endDate" />

      <button type="submit">Search Games</button>
    </form>

    <table>
      <thead>
        <tr>
          <th>Game ID</th>
          <th>Team</th>
          <th>Opponent</th>
          <th>Date</th>
          <th>Result</th>
          <th>PA</th>
          <th>AB</th>
          <th>R</th>
          <th>H</th>
          <th>2B</th>
          <th>3B</th>
          <th>HR</th>
          <th>RBI</th>
          <th>BB</th>
          <th>SO</th>
          <th>HBP</th>
          <th>GDP</th>
          <th>SB</th>
          <th>CS</th>
          <th>BA</th>
          <th>OBP</th>
          <th>SLG</th>
          <th>OPS</th>
          <th>LOB</th>

        </tr>
      </thead>
      <tbody>
        <tr v-for="game in games" :key="game['game_id']">
          <td>{{ game['game_id'] }}</td>
          <td>{{ game['team'] }}</td>
          <td>{{ game['opponent'] }}</td>
          <td>{{ formatDate(game['g_date']) }}</td>
          <td>{{ game['result'] }}</td>
          <td>{{ game['pa'] }}</td>
          <td>{{ game['ab'] }}</td>
          <td>{{ game['r'] }}</td>
          <td>{{ game['h'] }}</td>
          <td>{{ game['twob'] }}</td>
          <td>{{ game['threeb'] }}</td>
          <td>{{ game['hr'] }}</td>
          <td>{{ game['rbi'] }}</td>
          <td>{{ game['bb'] }}</td>
          <td>{{ game['so'] }}</td>
          <td>{{ game['hbp'] }}</td>
          <td>{{ game['gdp'] }}</td>
          <td>{{ game['sb'] }}</td>
          <td>{{ game['cs'] }}</td>
          <td>{{ game['ba'] }}</td>
          <td>{{ game['obp'] }}</td>
          <td>{{ game['slg'] }}</td>
          <td>{{ game['ops'] }}</td>
          <td>{{ game['lob'] }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import axios from 'axios';

export default defineComponent({
  name: 'GameList',
  data() {
    return {
      team: '',
      home: '',
      startDate: '',
      endDate: '',
      games: [],
    };
  },
  methods: {
    async fetchGames() {
      try {
        const response = await axios.get('/games', {
          params: {
            team: this.team,
            home: this.home,
            startDate: this.startDate,
            endDate: this.endDate,
          },
        });
        this.games = response.data;
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    },
    formatDate(dateString: string): string {
      const options: Intl.DateTimeFormatOptions = {
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
      };
      return new Date(dateString).toLocaleDateString(undefined, options);
    },
  },
});
</script>

<style scoped>
</style>
