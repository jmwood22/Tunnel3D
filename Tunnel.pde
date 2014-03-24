public class Tunnel
{
  int tunnelLength;
  float segmentLength, speed;
  TunnelPiece[] pieces;

  public Tunnel(int tLength, float segLength, float spd)
  {
    tunnelLength = tLength;
    segmentLength = segLength;
    speed = spd;

    pieces = new TunnelPiece[tunnelLength];

    for (int i = 0; i < tunnelLength; i++)
      pieces[i] = new TunnelPiece(segmentLength, i+1, speed, tunnelLength);
  }

  public void generate(float angle)
  {
    for (int i = 0; i < tunnelLength; i++)
    {
      if (pieces[i].getZPosition()>segmentHeight*4)
      {
        pieces[i].setZPosition(-((tunnelLength-4)*segmentHeight)+speed);
        if (random(100)<85)
        {
          pieces[i].setObstacle(false, 0);
        }
        else
        {
          pieces[i].setObstacle(true, random(100)*TWO_PI/100);
        }
      }
      pieces[i].generate(angle);
    }
  }
}

