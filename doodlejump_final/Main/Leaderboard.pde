import java.util.Map;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.io.PrintStream;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Leaderboard object 
 *   - stores the highscores in a hashmap
 *   - saves/loads highschores from file called scores.txt
 *   - displays highscores as a line on the side of the screen, when passed.
 */
 
class Leaderboard {
  private HashMap<String, Integer> scores; // hashmap of name-->score 
  
  // constructor - reads from file called scores.txt, else an empty map.
  public Leaderboard() {
    scores = new HashMap<String, Integer>(); 
    
    // read leaderboard file
    BufferedReader reader = createReader("scores.txt");
    String line = null;
    try {
      while ((line = reader.readLine()) != null) { // taken from processing example
        if (line == "") {continue;} // skip line if its null
        String[] name_score = split(line, ' ');
        if (name_score.length == 2){ 
          scores.put(name_score[0], Integer.valueOf(name_score[1]));
        }
      }
      reader.close();
    } catch (Exception e) {
      
    }
  }
  
  // Draws the highscores - O(n^2)
  public void draw() {
    ArrayList<Integer> drawn_values = new ArrayList<Integer>();
    for (Map.Entry<String, Integer> entry : scores.entrySet()) {
      String name = entry.getKey();
      Integer score = entry.getValue();
      
      // skip the highscore if it is too close to a previously drawn one...
      boolean skip = false;
      for (Integer past_score : drawn_values) {
        if (abs(past_score - score) < 50) {
          skip = true;
        }
      } if (skip) {continue;} 
      
      // draw the highscore.
      fill(0);
      stroke(255, 0, 0);
      pushMatrix();
        translate(0, +SCREEN_OFFSET);
        strokeWeight(5);
        textSize(12);
        text(name, width-70, height-score-20);
        text(score, width-70, height-score-8);
        line(width-70, height-score, width, height-score);
        strokeWeight(1);
      popMatrix();
      
      // the value is drawn
      drawn_values.add(score);
    }
    
  }
  
  // add a score to the leaderboard / update a highscore.
  public void addScore(String name, int score) {
    if (scores.containsKey(name)) {
      if (scores.get(name) < score) {
        scores.put(name, score);
      }
    } else {
      scores.put(name, score);  
    }
    
    // save the scores to file - per update
    saveScores();
  }
    
    
  // Save the scores to file using the printwriter
  public void saveScores() {
    
    // create a list of the lines to save to the file
    ArrayList<String> list = new ArrayList<String>();
    for (Map.Entry<String, Integer> entry : scores.entrySet()) {
      list.add(
        entry.getKey() + " " + entry.getValue() + "\n"
      );
    }
    
    // write the lines to file with a printWriter.
    String filename = "scores.txt";
    PrintWriter writer = createWriter(filename);
    try {
      for (String l : list) {writer.println(l);}
      writer.close();
    } catch (Exception e) {
      println("saving highscores failed!");
    }
  }
  
  
}
