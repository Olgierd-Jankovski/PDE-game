public class Player extends AnimatedSprite
{
  boolean onPlatform, inPlace;
  PImage[] standLeft, standRight, jumpLeft, jumpRight;

  // player moving interface
  public Player(PImage image, float scale)
  {
    super(image, scale);
    direction = right_dir;
    onPlatform = true;
    inPlace = true;
    
    // jumping
    jumpLeft = new PImage[1];
    jumpLeft[0] = loadImage("src/char_jumpl.png");
    
    jumpRight = new PImage[1];
    jumpRight[0] = loadImage("src/char_jumpr.png");
    
    // moving
    moveLeft = new PImage[2];
    moveLeft[0] = loadImage("src/char_movel2.png");
    moveLeft[1] = loadImage("src/char_movel1.png");
    
    moveRight = new PImage[2];
    moveRight[0] = loadImage("src/char_mover2.png");
    moveRight[1] = loadImage("src/char_mover1.png");

    // stationary
    standLeft = new PImage[1];
    standLeft[0] = loadImage("src/char_movel1.png");
    
    standRight = new PImage[1];
    standRight[0] = loadImage("src/char_mover1.png");
    
    currentImages = standRight;
  }
  
  public void selectCurrentImages()
  {
    if(direction == right_dir)
    {
      if(inPlace)
      {
        currentImages = standRight;
      }
      else if(!onPlatform)
      {
        currentImages = jumpRight;
      }
      else
      {
        currentImages = moveRight;
      }
    }
    
    else if(direction == left_dir)
    {
      if(inPlace)
      {
        currentImages = standLeft;
      }
      else if(!onPlatform)
      {
        currentImages = jumpLeft;
      }
      else
      {
        currentImages = moveLeft;
      }
    }
  }
  

  public void updateAnimation()
  {
    onPlatform = isOnPlatform(this, platforms);
    inPlace = change_x == 0 && change_y == 0;
    super.updateAnimation();
  }
  
  public void setDirection()
  {
    if(change_x > 0)
    {
      direction = right_dir;
    }
    else if(change_x < 0)
    {
      direction = left_dir;
    }
  }
  
}
