// src/services/dataService.ts
import axios from 'axios';

const apiUrl = 'http://localhost:8080'; 

export default {
  async fetchGames(options: any) {
    try {
      const response = await axios.get('/games', { params: options });
      return response.data;
    } catch (error) {
      console.error('Error fetching games:', error);
      throw error;
    }
  },
  async fetchPitches(options: any) {
    try {
      const response = await axios.get('/game_pitches', { params: options });
      return response.data;
    } catch (error) {
      console.error('Error fetching games:', error);
      throw error;
    }
  },
};
