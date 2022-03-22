public class World
{
  // variables
  float center_x, center_y, change_x, change_y, height, width;
  PImage image; 
  public World(String filename, float scale, float x, float y)
  {
    image = loadImage(filename);
    width = image.width * scale;
    height = image.height * scale;
    center_x = x;
    center_y = y;
    change_x = 0;
    change_y = 0;
  }
  
  public World(String filename, float scale)
  {
    this(filename, scale, 0, 0);
  }
  
  public World(PImage img, float scale)
  {
    image = img;
    width = image.width * scale;
    height = image.height * scale;
    center_x = 0;
    center_y = 0;
    change_x = 0;
    change_y = 0;
  }
  
  public void display()
  {
    image(image, center_x, center_y);
  }
  
  public void update()
  {
    center_x += change_x;
    center_y += change_y;
  }
  

  // generated setters and getters
  void setLeft(float left)
  {
    center_x = left + width/2;
  }
  
  float getLeft()
  {
    return center_x - width/2;
  }
  
  void setRight(float right)
  {
    center_x = right - width/2;
  }
  
  float getRight()
  {
    return center_x + width/2;
  }
  
  void setTop(float top)
  {
    center_y = top + height/2;
  }
  
  float getTop()
  {
    return center_y - height/2;
  }
  
  void setBottom(float bottom)
  {
    center_y = bottom - height/2;
  }
  
  float getBottom()
  {
    return center_y + height/2;
  }
}
