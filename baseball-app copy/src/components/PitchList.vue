<!-- src/components/PitchList.vue -->
<template>
    <div>
      <h1>Game Pitches</h1>
  
      <form @submit.prevent="fetchPitches">
        <label for="pitcher">Pitcher (last name):</label>
        <input v-model="pitcher" type="text" id="pitcher" />
  
        <label for="batter">Batter (last name):</label>
        <input v-model="batter" type="text" id="batter" />
  
        <label for="team">Team (3 letter abbreviation):</label>
        <input v-model="team" type="text" id="team" />
  
        <label for="startDate">Start Date:</label>
        <input v-model="startDate" type="date" id="startDate" />
  
        <label for="endDate">End Date:</label>
        <input v-model="endDate" type="date" id="endDate" />
  
        <button type="submit">Search Pitches</button>
      </form>
  
      <!-- Pitch table -->
      <table>
        <thead>
          <tr>
            <th>Game PK</th>
            <th>Game Date</th>
            <th>Batter</th>
            <th>Pitcher</th>
            <th>Home Team</th>
            <th>Away Team</th>
            <th>Inning</th>
            <th>Top/Bottom</th>
            <th>Pitch Type</th>
            <th>Balls</th>
            <th>Strikes</th>
            <th>Hit Location</th>
            <th>Pitch Number</th>
            <th>On First</th>
            <th>On Second</th>
            <th>On Third</th>
            <th>Home Score</th>
            <th>Away Score</th>
            <th>Post Home Score</th>
            <th>Post Away Score</th>
            <th>Launch Speed</th>
            <th>Launch Angle</th>
            <th>Hit Distance SC</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="pitch in pitches" :key="pitch['game_pk']">
            <td>{{ pitch['game_pk'] }}</td>
            <td>{{ pitch['game_date'] }}</td>
            <td>{{ pitch['batter'] }}</td>
            <td>{{ pitch['pitcher'] }}</td>
            <td>{{ pitch['home_team'] }}</td>
            <td>{{ pitch['away_team'] }}</td>
            <td>{{ pitch['inning'] }}</td>
            <td>{{ pitch['top_bot'] }}</td>
            <td>{{ pitch['pitch_type'] }}</td>
            <td>{{ pitch['balls'] }}</td>
            <td>{{ pitch['strikes'] }}</td>
            <td>{{ pitch['hit_location'] }}</td>
            <td>{{ pitch['pitch_number'] }}</td>
            <td>{{ pitch['on_first'] }}</td>
            <td>{{ pitch['on_second'] }}</td>
            <td>{{ pitch['on_third'] }}</td>
            <td>{{ pitch['home_score'] }}</td>
            <td>{{ pitch['away_score'] }}</td>
            <td>{{ pitch['post_home_score'] }}</td>
            <td>{{ pitch['post_away_score'] }}</td>
            <td>{{ pitch['launch_speed'] }}</td>
            <td>{{ pitch['launch_angle'] }}</td>
            <td>{{ pitch['hit_distance_sc'] }}</td>
          </tr>
        </tbody>
      </table>
    </div>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import axios from 'axios';
  
  interface PitchData {
    game_pk: number;
    game_date: string;
    batter: string;
    pitcher: string;
    home_team: string;
    away_team: string;
    inning: number;
    top_bot: string;
    pitch_type: string;
    balls: number;
    strikes: number;
    hit_location: string;
    pitch_number: number;
    on_first: string;
    on_second: string;
    on_third: string;
    home_score: number;
    away_score: number;
    post_home_score: number;
    post_away_score: number;
    launch_speed: number;
    launch_angle: number;
    hit_distance_sc: number;
    // Add more properties based on your actual data structure
  }
  
  export default defineComponent({
    name: 'PitchList',
    data() {
      return {
        pitcher: '',
        batter: '',
        team: '',
        startDate: '',
        endDate: '',
        pitches: [],
      };
    },
    methods: {
      async fetchPitches() {
        try {
          const response = await axios.get('/game_pitches', {
            params: {
              pitcher: this.pitcher,
              batter: this.batter,
              team: this.team,
              startDate: this.startDate,
              endDate: this.endDate,
            },
          });
          this.pitches = response.data;
        } catch (error) {
          console.error('Error fetching pitch data:', error);
        }
      },
    },
  });
  </script>
  
  <style scoped>
  </style>
  