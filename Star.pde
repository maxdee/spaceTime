class Star {

  //----------------Properties-------------//
  //position of stars in galaxy
  float fakeX;
  float fakeY;
  float fakeZ; 

  //----------------Constructor-------------//
  public Star() {
    init();
  }
  
  //random star
  private void init() {
    fakeX = random(0, width)-width/2;
    fakeY = random(0, height)-height/2;
    fakeZ = random(0, width+height);
  }

  public void draw() {
    //advance through space
    fakeZ-=speed;
    stroke(255);
    //3d projection, simple and effective!
    float x = (fakeX*zoom)/fakeZ;
    float y = (fakeY*zoom)/fakeZ;
    point(x, y);
    //infinit space!
    if (abs(x) >= width/2 || abs(y) >= height/2) {
      init();
    }
  }
}

