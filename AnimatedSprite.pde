public class AnimatedSprite extends World
{
  PImage[] currentImages, stand, moveLeft, moveRight;
  int direction, index, frame;
  
  public AnimatedSprite(PImage image, float scale)
  {
    super(image, scale);
    direction = idle;
    index = 0;
    frame = 0;
  }
  
  public void updateAnimation()
  {
    frame++;
    if(frame % 5 == 0)
    {
      setDirection();
      selectCurrentImages();
      setNextImage();
    }
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
    else
    {
      direction = idle;
    }
  }
  
  public void setNextImage()
  {
    index++;
    if(index >= currentImages.length)
    {
      index = 0; 
    }
    image = currentImages[index];
  }

  public void selectCurrentImages()
  {
    if(direction == right_dir)
    {
      currentImages = moveRight;
    }
    else if(direction == left_dir)
    {
      currentImages = moveLeft;
    }
    else
    {
      currentImages = stand;
    }
  }
  
}
