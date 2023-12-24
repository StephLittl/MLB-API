
const express = require('express')
const { Pool } = require('pg');
const cors = require("cors");
const app = express()
const port = 8080

const pool = new Pool({
  user: 'mlb_user',
  host: 'localhost',
  database: 'mlb',
  password: 'baseball',
  port: 5432,
});

app.get('/', (req, res) => {
  res.send('Welcome to Steph\'s MLB API!')
})

app.use(express.json());
app.use(cors());


app.get('/teams', async (req, res) => {
  try {
    let { name, attr }= req.query;
    let query = 'SELECT * FROM teams WHERE 1 = 1';

    const parameters = [];

    if (name !== undefined && name !== null && name !== '') {
      query += ' AND team = $' + (parameters.length + 1);
      parameters.push(name);
    }
    
    let possible_values = ['hr', 'r', 'bb', 'age']
    if (possible_values.includes(attr)) {
      const validAttributes = ['hr', 'r', 'bb', 'age'];
      if (validAttributes.includes(attr)) {
        query += ' ORDER BY ' + attr + ' DESC'; 
        //parameters.push(attr);
      } else {
        res.status(400).json({ error: 'Invalid attribute for sorting' });
        return;
      }
    }
    
    const { rows } = await pool.query(query, parameters);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('failed');
  }
});

app.get('/batters', async (req, res) => {
  try {
    let { team, last_name, obp, min_pas, attr } = req.query;
    
    let query = 'SELECT * FROM batters WHERE 1=1';
    
    const parameters = [];

    if (team) {
      query += ' AND team like $' + (parameters.length + 1);
      parameters.push(team);
    }    
    if (last_name) {
      query += ' AND last_name = $' + (parameters.length + 1);
      parameters.push(last_name);
    }
    if (obp) {
      query += ' AND obp < $' + (parameters.length + 1) + '::float';
      parameters.push(obp);
    }
    if (min_pas) {
      query += ' AND pa > $' + (parameters.length + 1) + '::int';
      parameters.push(min_pas);
    }
    let possible_values = ['ba', 'obp', 'slg', 'hr', 'bb']
      if (possible_values.includes(attr)) {
      const validAttributes = ['ba', 'obp', 'slg', 'hr', 'bb'];
      if (validAttributes.includes(attr) && attr != "") {
          query += ' ORDER BY ' + attr + ' DESC'; 
      } else {
        res.status(400).json({ error: 'Invalid attribute for sorting' });
        return;
      }
    }
    const { rows } = await pool.query(query, parameters);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Failed');
  }
});


app.get('/pitchers', async (req, res) => {
  try {
    let { team, last_name, era, min_innings, attr } = req.query;
    
    let query = 'SELECT * FROM pitchers WHERE 1=1';
    
    const parameters = [];

    if (team) {
      query += ' AND team like $' + (parameters.length + 1);
      parameters.push(team);
    }    
    if (last_name) {
      query += ' AND last_name = $' + (parameters.length + 1);
      parameters.push(last_name);
    }
    if (era) {
      query += ' AND era < $' + (parameters.length + 1) + '::float';
      parameters.push(era);
    }
    if (min_innings) {
      query += ' AND ip > $' + (parameters.length + 1) + '::float';
      parameters.push(min_innings);
    }
    possible_values = ['w', 'g', 'ip', 'whip', 'era'];
    if (possible_values.includes(attr)) {
      const validAttributes = ['w', 'g', 'ip', 'whip', 'era'];
      if (validAttributes.includes(attr)) {
        // Use string interpolation for the column name in the ORDER BY clause
        if (attr == 'w' || attr == 'g' || attr == 'ip'){
          query += ' ORDER BY ' + attr + ' DESC'; // or ASC, depending on your needs
        }else{
          query += ' ORDER BY ' + attr + ' ASC';
        }
      } else {
        // Handle invalid 'attr' values
        res.status(400).json({ error: 'Invalid attribute for sorting' });
        return;
      }
    }
    const { rows } = await pool.query(query, parameters);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Failed');
  }
});

app.get('/games', async (req, res) => {
  try {
    let { team, home, startDate, endDate } = req.query;
    
    
    let query = 'SELECT * FROM games WHERE 1=1';
    
    const parameters = [];

    if (team) {
      query += ' AND team = $' + (parameters.length + 1);
      parameters.push(team);
    }    
    if (home) {
      const homeOrAway = '$' + (parameters.length + 1) + '::boolean';
      query += ' AND home = ' + homeOrAway;
      parameters.push(home);
    }
    
    if (startDate && endDate) {
      query += ' AND g_date BETWEEN $' + (parameters.length + 1) + ' AND $' + (parameters.length + 2);
      parameters.push(startDate, endDate);
    } else if (startDate) {
      query += ' AND g_date >= $' + (parameters.length + 1);
      parameters.push(startDate);
    } else if (endDate) {
      query += ' AND g_date <= $' + (parameters.length + 1);
      parameters.push(endDate);
    }
    const { rows } = await pool.query(query, parameters);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Failed');
  }
});

app.get('/game_pitches', async (req, res) => {
  try {
    let { pitcher, batter, team, startDate, endDate } = req.query;
    
    let query = 'SELECT * FROM game_pitches WHERE 1=1';
    
    const parameters = [];

    if (pitcher) {
      query += ' AND pitcher IN (SELECT mlbID FROM pitchers WHERE last_name = $' + (parameters.length + 1) + ')';
      parameters.push(pitcher);
    }
    
    if (batter) {
      query += ' AND batter IN (SELECT mlbID FROM batters WHERE last_name = $' + (parameters.length + 1) + ')';
      parameters.push(batter);
    }
    
    if (team) {
      query += ' AND (home_team = $' + (parameters.length + 1) + ' OR away_team = $' + (parameters.length + 2) + ')';
      parameters.push(team, team);
    }
    
    if (startDate && endDate) {
      query += ' AND g_date BETWEEN $' + (parameters.length + 1) + ' AND $' + (parameters.length + 2);
      parameters.push(startDate, endDate);
    } else if (startDate) {
      query += ' AND g_date >= $' + (parameters.length + 1);
      parameters.push(startDate);
    } else if (endDate) {
      query += ' AND g_date <= $' + (parameters.length + 1);
      parameters.push(endDate);
    }
    
    const { rows } = await pool.query(query, parameters);
    res.status(200).json(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send('Failed');
  }
});

app.get('/help', async (req, res) => {
  res.send('Endpoints: <br><br>/teams: gets team wide statistics<br>  team={three letter team abbreviation}  -> returns just the statistics for the team you are seraching for<br>   attr={hr, r, bb, age}  -> sorts the teams by the specified attribute (home runs, runs, walks, or average age) <br><br>/batters: gets statistics for hitters <br> team={city}  -> returns the statistics for hitters on one team <br>  last_name={hitter\'s last name} -> returns the stats for any hitter with a matching last name <br> obp={float} -> returns the stats for all hitters with an opb grerater than the given number <br> min_pas={integer} -> returns the stats for all hitters with more plate appearances than the given integer <br> attr={ba, obp, slg, hr, bb} -> returns the hitter statistics sorted by batting average, on base percentage, slugging, home runs, or walks<br><br>/pitchers: gets statistics for pitchers <br> team={city}  -> returns the statistics for pitchers on one team <br>  last_name={pitcher\'s last name} -> returns the stats for any pitcher with a matching last name <br> era={float} -> returns the stats for all pitchers with an ERA less than the given number <br> min_innings={float} -> returns the stats for all pitchers with more innings pitcheed than the given number <br> attr={w, g, ip, whip, era} -> returns the pitcher statistics sorted by wins, games, innings pitched, WHIP, or ERA<br><br>/games: gets the game results and statistics for each team<br>  team={three letter team abbreviation}  -> returns just the games for the team you are seraching for<br> home={true, false} -> returns only home (true) or away (false) games (best used with team selection)  <br> startDate{YYYY-MM-DD -> returns only games after the specified date <br> endDate{YYYY-MM-DD} -> returns only games before the specified date <br><br>/game_pitches: gets the pitches, their corresponding context (i.e. game, inning, count), and the result of the pitch <br>  pitcher={pitcher\'s last name} -> returns only the pitches thrown by a pitcher with that last name <br> hitter={hitter\'s last name} -> returns only pitches thrown to a hitter with that last name <br> team={three letter team abbreviation}  -> returns just the pitches thrown in games where the given team played  <br> startDate{YYYY-MM-DD -> returns only pitches thrown after the specified date <br> endDate{YYYY-MM-DD} -> returns only pitches thrown before the specified date ');
  //give examples?
  //res.send('format: /endpoint?')
  //res.send('<br><br>Note: see the ReadMe file in the git repository for examples')
  // need to note that the data is only for 2023
  // /teams?team=CLE
  // returns the Cleveland's team stats
  // /teams?attr=hr
  // returns the every teams stats, sort by number of home runs
  // /batters?team=Cleveland&attr=hr
  // returns all of Cleveland's hitters, sorted by number of home runs
  // /batters?last_name=Kwan
  // returns the stats of every hitter with the last name Kwan
  // /batters?obp=.35&min_pas=100&attr=obp
  // returns all batters with OBP greater than 0.350 who have had at least 100 at bats, sorted by OBP
  // /pitchers?last_name=Bieber
  // returns the pitching stats for all pitchers with last name Bieber
  // /pitchers?team=Cleveland&attr=w
  // returns all the Cleveland pitchers, sorted by their number of wins
  // /pitchers?era=3&min_innings=40
  // returns all pitchers who have ERA less than 3 and who have pitched at least 40 innings
  // /games?team=CLE&home=true
  // returns all of Cleveland's home games
  // /games?startDate=2023-06-01&endDate2023-06-30
  // returns all games in June
  // /game_pitches?pitcher=Bieber&hitter=Devers
  // returns the details of every pitch Bieber has thrown to Devers
  // /game_pitches?team=CLE&startDate=2023-04-05&endDate=2023-04-05
  // returns the details of all of the pitches in Cleveland's game on 2023-04-05
});



const PORT = 8080;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});