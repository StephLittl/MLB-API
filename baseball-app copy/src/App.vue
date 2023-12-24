<template>
  <div id="app">
    <h1>MLB Web App by Stephanie Little</h1>

    <!-- Dropdown menu to switch between Lists -->
    <label for="componentSelector">Select Component:</label>
    <select v-model="selectedComponent" id="componentSelector">
      <option value="TeamList">Teams</option>
      <option value="BatterList">Hitters</option>
      <option value="PitcherList">Pitchers</option>
      <option value="GameList">Games</option>
      <option value="PitchList">Pitches</option>
      
      
    </select>

    <!-- Render the selected component based on the dropdown value -->
    <component :is="selectedComponent" />

  </div>
</template>

<script>
import TeamList from './components/TeamList.vue';
import BatterList from './components/BatterList.vue';
import PitcherList from './components/PitcherList.vue';
import GameList from './components/GameList.vue';
import PitchList from './components/PitchList.vue';



export default {
  name: 'App',
  components: {
    TeamList, 
    BatterList,
    PitcherList,
    GameList,
    PitchList,
  },
  data() {
    return {
      selectedComponent: 'TeamList', // Default selected component
    };
  },
};
</script>




<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
