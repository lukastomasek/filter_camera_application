public class Button {
  String label; // button label
  float x;      // top left corner x position
  float y;      // top left corner y position
  float w;      // width of button
  float h;      // height of button
  PImage icon;
  // constructor
  Button(PImage iconB, String labelB, float xpos, float ypos, float widthB, float heightB) {
    icon = iconB;
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
  }
  void Draw(float imgW, float imgH, int size, Boolean reactToMouseOver) {

    if (MouseIsOver() && reactToMouseOver ) {
      //fill(47, 77, 255);
      tint(255, 127);
    } else {  
      fill(0, 0, 0, 0);
      tint(255, 255);
      //fill(55, 141, 255);
    }
    
    image(icon, imgW, imgH );
    icon.resize(size, size);
    noStroke();
    //stroke(255);
    rect(x, y, w, h, 10);
    //textAlign(CENTER, CENTER);
    //textSize(12);
    //fill(255);
    //text(label, x + (w / 2), y + (h / 2));
  }

  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
