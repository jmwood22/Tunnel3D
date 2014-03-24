public class TunnelPiece
{

  float angle;
  float obsAngle;
  float[] x, z, j, k;
  float zPos;
  float segmentHeight;
  float initialZ;
  boolean obs;
  float speed;
  int tunnelLength, pos;
  PShape tunnelSegment, obstacleSegment;
  float sensorAngle = 0;

  public TunnelPiece(float h, int p, float spd, int tLength)
  {
    segmentHeight = h;
    pos = p;
    initialZ = (-(pos-1) * segmentHeight) + (segmentHeight*4);
    zPos = initialZ;
    obs = false;
    speed = spd;
    tunnelLength = tLength;

    tunnelSegment = createShape();
    obstacleSegment = createShape();

    cylinderBox(segmentHeight/2, segmentHeight, 100);
    cylinder(segmentHeight/2, segmentHeight, 100);
  }

  public void generate(float a)
  {

    pushMatrix();

    translate(width/2, height/2, zPos);
    rotateX(PI/2);
    rotateY(sensorAngle);
    sensorAngle = sensorAngle - a;
    rotateY(-a);
    if (obs)
      cylinderBox(segmentHeight/2, segmentHeight, 100);
    else
    {
      cylinder(segmentHeight/2, segmentHeight, 100);
    }

    popMatrix();

    zPos+=speed;
  }

  public float getZPosition()
  {
    return zPos;
  }

  public void setZPosition(float zP)
  {
    zPos = zP;
  }

  public void setObstacle(boolean y, float a)
  {
    obs = y;
    obsAngle = a;
  }

  public void cylinder(float w, float h, int sides)
  {
    x = new float[sides+1];
    z = new float[sides+1];

    //****************get the x and z position on a circle for all the sides****************
    for (int i=0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * w;
      z[i] = cos(angle) * w;
    }
    /*
    //****************draw the top of the cylinder****************
     beginShape();
     noStroke();
     noFill();
     vertex(0, -h/2, 0);
     
     for (int i=0; i < x.length; i++) {
     vertex(x[i], -h/2, z[i]);
     }
     endShape();
     fill(255);
     */
    // noStroke();
    //****************draw the center of the cylinder****************
    beginShape(QUAD_STRIP); 
    fill(80, 100, 255);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
      vertex(x[i], h/2, z[i]);
    }

    endShape();
    fill(255);
    //****************draw the bottom of the cylinder****************
    beginShape(); 
    stroke(0);
    strokeWeight(2);
    noFill();
    //vertex(0, h/2, 0);

    for (int i=0; i < x.length; i++) 
    {
      vertex(x[i], h/2, z[i]);
    }

    endShape();
    noStroke();
    strokeWeight(1);
    fill(255);
  }



  public void cylinderBox(float w, float h, int sides)
  {
    rotateY(obsAngle);


    x = new float[sides+1];
    z = new float[sides+1];
    j = new float[sides+1];
    k = new float[sides+1];

    //****************get the x and z position on a circle for all the sides****************
    for (int i=0; i < x.length; i++) {
      angle = TWO_PI / (sides) * i;
      x[i] = sin(angle) * w;
      z[i] = cos(angle) * w;
      j[i] = sin(angle) * (w*.8);
      k[i] = cos(angle) * (w*.8);
    }

    //noStroke();
    //****************draw the center of the cylinder****************
    beginShape(QUAD_STRIP); 
    noStroke();
    fill(80, 100, 255);
    for (int i=0; i < x.length; i++) {
      vertex(x[i], -h/2, z[i]);
      vertex(x[i], h/2, z[i]);
    }
    endShape();

    //****************draw obstacle****************
    beginShape();
    stroke(0);
    strokeWeight(4);
    fill(200, 60, 50);
    for (int i = 0; i<x.length/6; i++)
      vertex(x[i], h/2, z[i]);
    vertex(j[j.length/6-1], h/2, k[j.length/6-1]);
    vertex(j[0], h/2, k[0]);
    endShape(CLOSE);

    beginShape();
    stroke(0);
    strokeWeight(4);
    fill(200, 60, 50);
    vertex(x[x.length/6 -1], h/2, z[x.length/6 -1]);
    vertex(x[x.length/6 -1], -h/2, z[x.length/6 -1]);
    vertex(j[x.length/6 -1], -h/2, k[x.length/6 -1]);
    vertex(j[x.length/6 -1], h/2, k[x.length/6 -1]);
    endShape(CLOSE);

    beginShape();
    stroke(0);
    strokeWeight(4);
    fill(200, 60, 50);
    vertex(x[0], h/2, z[0]);
    vertex(x[0], -h/2, z[0]);
    vertex(j[0], -h/2, k[0]);
    vertex(j[0], h/2, k[0]);
    endShape(CLOSE);

    beginShape();
    stroke(0);
    strokeWeight(4);
    fill(200, 60, 50);
    vertex(j[0], h/2, k[0]);
    vertex(j[0], -h/2, k[0]);
    vertex(j[j.length/6-1], -h/2, k[j.length/6-1]);
    vertex(j[j.length/6-1], h/2, k[j.length/6-1]);
    endShape(CLOSE);

    beginShape();
    stroke(0);
    strokeWeight(4);
    fill(200, 60, 50);
    for (int i = 0; i<x.length/6; i++)
      vertex(x[i], -h/2, z[i]);
    vertex(j[j.length/6-1], -h/2, k[j.length/6-1]);
    vertex(j[0], -h/2, k[0]);
    endShape(CLOSE);

    fill(255);
    strokeWeight(1);


    //****************draw the bottom of the cylinder****************
    beginShape(); 
    stroke(0);
    strokeWeight(2);
    noFill();
    //vertex(0, h/2, 0);

    for (int i=0; i < x.length; i++) 
    {
      vertex(x[i], h/2, z[i]);
    }

    endShape();
    noStroke();
    strokeWeight(1);
    fill(255);
  }
}

