import android.view.WindowManager;
import android.view.View;
import android.os.Bundle;
import processing.opengl.*;
import ketai.sensors.*;

Tunnel tunnel;
Player player;

float rotationX, rotationY, rotationZ, angle;

KetaiSensor sensor;

float aLight, sLight;

int tunnelLength;
float segmentHeight, speed, playerRadius;

void setup() 
{
  size(displayWidth, displayHeight, P3D);
  //hint();
  frameRate(60);

  tunnelLength = 20;
  segmentHeight = height/(2);
  speed = segmentHeight/10;
  playerRadius = height/36;

  tunnel = new Tunnel(tunnelLength, segmentHeight, speed);
  player = new Player(playerRadius, segmentHeight);
  sensor = new KetaiSensor(this);
  sensor.start();
  
  angle = 0;
  aLight = 0;
  sLight = 0;
}  

void draw() 
{
  background(0);
  noStroke();
  
  camera(width/2, height/2+50, (height/2.0) / tan(PI*30.0 / 180.0), width/2-100, height/2, -2000, 0, 1, 0);
  
  lightFalloff(1.0, 0.002 + aLight, 0.0);
  ambientLight(255, 255, 255, width/2, height/2 + 200 - 30, 400);

  lightFalloff(1.0, 0.0015 + sLight, 0.0);
  spotLight(255, 255, 255, width/2, height/2, 600, 0, 0, -1, PI/12, 200); 
  
  //lightFalloff(1.0, 0.0015, 0.0);
  //pointLight(255, 255, 255, width/2 - 200 + 30, height/2, 600);
  //lightFalloff(1.0, 0.0015, 0.0);
  //pointLight(255, 255, 255, width/2 - 200 +30, height/2, 500);

  angle = atan(rotationY/rotationX);
  
  tunnel.generate(angle/4);
  player.generate();
  
  aLight += 0.000001;
  sLight += 0.0000001;
}

void onCreate(Bundle bundle) 
{
  super.onCreate(bundle);
  // fix so screen doesn't go to sleep when app is active
  getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
}


void onAccelerometerEvent(float x, float y, float z)
{  
  if (abs(rotationX-x)>0.25)
    rotationX = x;
  if (abs(-rotationY-y)>0.25)
    rotationY = -y;
  if (abs(rotationZ-z)>0.25)
    rotationZ = z;

  if (rotationX<0)
    rotationX = -rotationX;
}

