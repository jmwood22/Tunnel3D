public class Player
{
  float radius;
  float segmentHeight;

  public Player(float r, float h)
  {
    radius = r;
    segmentHeight = h;
  }

  public void generate()
  {
    pushMatrix();
    //pushStyle();
    translate(width/2, height/2 + segmentHeight/2 - radius, 400);
    noStroke();
    fill(155);
    sphere(radius);
    //popStyle();
    popMatrix();
  }
}

