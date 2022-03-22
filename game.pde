/*
  @Olgierd Jankovski, 5 grupe, LSP: 2110561
  */

// kintmauju deklaravimas
final static float movement_speed = 8.0;
final static float world_scale = 64/64;
final static int block_size = 64;
final static float gravity = 0.4;
final static float jump_speed = 10;
final static float screen_width = block_size * 1;
final static float screen_height = block_size * 10;
final static float ground = screen_height - block_size;
final static int idle = 0;
final static int right_dir = 1;
final static int left_dir = 2;
float view_x;
float view_y;
Player p;
PImage character, tiles, imageHolder;
PImage[] imageArray;
ArrayList <World> platforms;

boolean isGameOver;
boolean spikes;
boolean win = false;
boolean show = false;

int currentLevel = 1;
int timesPressed = 0;
int imagePointer, col, row, pos_x, pos_y;

int[] csvMapLevel1 = 
{
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,14,14,14,4,4,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,21,4,4,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,14,4,14,14,14,2,14,14,14,14,14,4,4,14,14,4,4,14,14,14,4,4,14,14,4,14,14,14,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,21,4,4,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,14,4,14,14,14,4,14,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,1,4,21,4,4,4,4,4,4,4,
  0,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,14,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,2,14,14,14,14,14,14,14,14,2,2,14,14,14,14,14,21,14,14,14,14,14,14,14,
  14,14,14,14,14,14,14,14,2,14,14,14,14,14,14,14,2,14,14,14,14,14,14,4,4,14,14,14,14,14,14,4,4,14,14,14,14,14,14,4,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,
  21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,4,4,21,21,21,21,21,21,4,4,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,
  21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,4,4,21,21,21,21,21,21,4,4,21,21,21,21,21,21,4,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21,21
};

int[] csvMapLevel2 = 
{
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,50,50,50,50,50,50,4,4,4,50,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,13,13,4,4,49,4,4,4,50,4,4,4,50,4,4,4,4,4,50,4,4,4,4,4,4,4,4,4,4,4,43,4,4,4,4,50,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,13,13,4,4,4,4,42,4,4,4,36,4,4,4,43,2,4,12,4,2,43,4,4,4,4,4,4,4,4,4,4,4,43,2,2,2,2,36,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,1,4,4,4,12,12,12,12,4,4,4,4,4,
  13,13,13,13,13,13,13,13,13,13,13,4,4,4,4,4,4,42,4,4,4,43,4,4,4,43,4,2,12,2,4,43,4,4,4,4,4,4,4,4,4,4,4,43,4,4,4,4,43,4,4,13,13,13,13,13,13,13,13,13,13,13,52,52,52,13,13,13,13,50,50,50,13,13,13,13,13,13,13,50,52,52,13,13,13,13,13,13,13,13,13,12,12,12,12,4,4,4,4,4,
  13,13,13,13,13,13,13,13,13,13,13,4,4,4,4,4,4,42,4,4,4,43,4,4,4,43,4,4,12,4,4,43,2,2,52,52,52,52,52,52,4,4,4,43,4,4,4,4,43,4,4,12,12,12,12,12,12,12,12,12,12,12,2,2,2,12,12,12,12,2,2,2,12,12,12,12,12,12,12,2,2,2,12,12,12,12,12,12,12,12,12,12,12,12,12,4,4,4,4,4,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,42,4,4,4,43,4,4,4,43,4,4,12,4,4,43,21,21,21,21,21,21,21,21,4,4,4,43,4,4,4,4,43,4,4,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,4,4,4,4,4
};

int[] csvMapLevel3 = 
{
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,
  4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,11,11,11,
  4,4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,11,11,11,
  4,4,4,4,4,4,4,4,4,11,4,4,4,4,4,4,4,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,24,24,24,24,24,24,24,24,24,2,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,11,11,11,
  4,4,4,4,4,4,4,11,4,4,4,4,4,11,4,4,4,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,2,2,2,24,24,24,24,11,11,11,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,2,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,11,11,11,
  4,4,4,4,4,11,4,4,4,4,4,4,4,4,4,4,4,4,4,4,24,24,24,24,24,24,24,24,24,10,24,24,24,10,24,24,24,10,24,24,24,24,24,24,24,24,24,24,24,11,11,11,24,24,24,24,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,4,24,24,11,11,11,11,
  4,4,4,4,11,4,4,2,2,2,2,2,2,2,4,4,4,4,4,4,24,24,24,24,24,10,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,10,24,24,24,24,24,24,24,24,24,24,24,24,24,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,1,24,24,11,11,11,11,
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,24,11,24,2,2,2,2,2,2,2,24,24,24,24,24,24,24,24,24,24,2,24,24,24,24,2,24,24,24,24,2,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,2,2,2,11,11,11,2,2,11,11,2,2,2,11,11,11,24,24,24,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,52,52,52,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,
  11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,24,24,24,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,52,52,52,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11,11
};


// initial environment properties execution
void setup()
{
  size(960,540);
  imageMode(CENTER);
  character = loadImage("src/char_mover1.png");
  
  gameInit();

  tiles = loadImage("src/tiles.png");
  col = tiles.width / block_size;
  row = tiles.height / block_size;

  initImageArray();
  
  createLevel();

  nullView();

}

// initialising game data
void gameInit()
{
  p = new Player(character, 1.0);
  p.setBottom(ground);
  p.center_x = 128;
  platforms = new ArrayList <World>();
  isGameOver = false;
  spikes = false;
  win = false;
}

// setting view axis to null
void nullView()
{
  view_x = 0;
  view_y = 0;
}

// runs continuously from top to bottom until the the program is stopped
void draw()
{
  background(34, 139, 34); // clear screen with wanted background
  stroke(255); // setting drawing color line to white
  screenFocus(); // moves left to write to change the position of the images
  for(World s: platforms)
  {
   s.display(); 
  }
  p.display();
  
  if(show == true) // opening tile sheet to modify current csv map array
  {
    image(tiles, view_x + (tiles.width / 4), view_y + (tiles.height / 4), 448 / 2, 542 / 2);
    image(imageHolder, mouseX + view_x, mouseY + view_y, 64, 64);
  }
  
  if(isGameOver == true)
  {
    fill(0);
    textSize(64);
    if(win)
    {
      if (currentLevel > 3)
      {
        text("You Won!", view_x + width / 2 - 150, view_y + height / 2);
      }
      else
      {
         text("Next Level!", view_x + width / 2 - 150, view_y + height / 2);
      }
    }
    else
    {
      text("Game Over!", view_x + width / 2 - 150, view_y + height / 2);
    }
  }
  
  if(isGameOver != true)
  {
    p.updateAnimation();
    resolvePlatformCollisions(p, platforms);
    checkIsDead();
  }
  
}

// generating current level of the map
void createLevel()
{
  if(currentLevel == 1)
  {
    initPlatform(csvMapLevel1);
  }
  if(currentLevel == 2)
  {
    initPlatform(csvMapLevel2);
  }
  else if (currentLevel == 3)
  {
    initPlatform(csvMapLevel3);
  }
  else
  {
    initPlatform(csvMapLevel1);
  }
}

// checking the values of integers
void checkIsDead()
{
  boolean fall = p.getBottom() > ground;
  if(win || fall || spikes)
  {
    isGameOver = true;
  }
}

// scroll()
void screenFocus()
{
  float rBoundary = view_x + width - 400;
  if(p.getRight() > rBoundary)
  {
    view_x += p.getRight() - rBoundary;
  }
 
  float lBoundary = view_x + 60;
  if(p.getLeft() < lBoundary)
  {
    view_x = view_x - lBoundary + p.getLeft();
  }
  
  float bBoundary = view_y + height - 40;
  if(p.getBottom() > bBoundary)
  {
    view_y = view_y + p.getBottom() - bBoundary;
  }
  
  float tBoundary = view_y + 40;
  if(p.getTop() < tBoundary)
  {
    view_y = view_y - tBoundary + p.getTop();
  }
  translate(- view_x, - view_y);
}

// checking whether the player is standing on the platform
public boolean isOnPlatform(World s, ArrayList <World> object)
{
  s.center_y = s.center_y + 5;
  ArrayList <World> collision = checkCollisionList(s, object);
  s.center_y = s.center_y - 5;
  if(collision.size() > 0)
  {
    return true;
  }
  else
  {
    return false;
  }
}

// checking whether the collision occurs with the given tiles
boolean checkCollision(World s1, World s2)
{
  boolean noXOverlap, noYOverlap;
  
  if(s2.image != imageArray[4] && 
     s2.image != imageArray[0] && 
     s2.image != imageArray[52] && 
     s2.image != imageArray[24])
  {
    noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
    noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  }
  else
  {
    noXOverlap = true;
    noYOverlap = true;
  }

  if(noXOverlap || noYOverlap)
  {
    return false;
  }
  else
  {
    return true;
  }
}

/*
  Given a World (Sprite) and and ArrayList of Sprites,
  return and ArrayList of Sprites which collide with
  given sprite
*/
public ArrayList <World> checkCollisionList (World s, ArrayList <World> list)
{
  ArrayList <World> collision_list = new ArrayList <World>();
  for(World p: list)
  {
    if(checkCollision(s, p))
    {
      collision_list.add(p);
    }
  }
  return collision_list;
}

// using key arrows
void keyPressed()
{
  if(keyCode == RIGHT)
  {
    p.change_x = movement_speed;
  }
  else if(keyCode == LEFT)
  {
    p.change_x = -movement_speed;
  }

  else if(keyCode == UP && isOnPlatform(p, platforms))
  {
    p.change_y = -jump_speed;
  }
  else if(isGameOver && key == ' ')
  {
    setup();
  }

  else if(key == 'm')
  {
    timesPressed++;

    if(timesPressed > 1)
    {
      show = false;
      timesPressed = 0;
    }
    else
    {
      show = true;
    }
  }
}

// returing change_x/y values to basic whenever control key's are released
void keyReleased()
{
  if(keyCode == RIGHT)
  {
    p.change_x = 0;
  }
  else if(keyCode == LEFT)
  {
    p.change_x = 0;
  }
}

// looks out for mouse events
void mousePressed()
{
  if(show && mouseX + view_x > -1 && 
    mouseX < (tiles.width / 2) &&
    mouseY + view_y > -1 &&
    mouseY < (tiles.height / 2))
  {
    imagePointer = mouseY / (block_size / 2) * col + mouseX / (block_size / 2);
    imageHolder = imageArray[imagePointer];
  }
  if(show &&  (mouseX + view_x > (tiles.width / 2) + view_x || 
               mouseY + view_y > (tiles.height / 2) + view_y))
  {
  
    mouseX += view_x;
    mouseY += view_y;
    pos_x = mouseX / block_size;
    pos_y = mouseY / block_size;
    if(currentLevel == 1)
    {
      csvMapLevel1[pos_y * 100 + pos_x] = imagePointer;
      initPlatform(csvMapLevel1);
    }
    if(currentLevel == 2)
    {
      csvMapLevel2[pos_y * 100 + pos_x] = imagePointer;
      initPlatform(csvMapLevel2);
    }
    else if (currentLevel == 3)
    {
      csvMapLevel3[pos_y * 100 + pos_x] = imagePointer;
      initPlatform(csvMapLevel3);
    }
    else
    {
      csvMapLevel1[pos_y * 100 + pos_x] = imagePointer;
      initPlatform(csvMapLevel1);
    }
  }
 
}

// generating image array
void initImageArray()
{
    imageArray = new PImage[col * row];
    for(int i = 0; i < row; i++) 
    {
      for(int j = 0; j < col; j++) 
      {
        imageHolder = tiles.get(j * block_size, i * block_size, block_size, block_size);
        imageArray[i * col + j] = imageHolder;
      }
   }
}

// creating platform
void initPlatform(int[] worldArray)
{
  for(int rows = 0; rows < 10; rows++)
  {
    for(int columns = 0; columns < 100; columns++)
    {
      int index = worldArray[rows * 100 + columns]; 
      World s = new World(imageArray[index], world_scale);
      s.center_x =  block_size / 2 + columns * block_size;
      s.center_y =  block_size / 2 + rows * block_size;
      platforms.add(s);
    }
  }
}

// resolving collisions by computing collision list and fixing the collisions
public void resolvePlatformCollisions(World s, ArrayList <World> object)
{
  s.change_y = s.change_y + gravity;
  s.center_y = s.center_y + s.change_y;
  ArrayList <World> collisions = checkCollisionList(s, object);
  if(collisions.size() > 0)
  { 
    World collided = collisions.get(0);
    if(collided.image == imageArray[2])
    {
      spikes = true;
    }
    if(collided.image == imageArray[1])
    {
      win = true;
      currentLevel++;
    }
    if(s.change_y > 0)
    { 
      s.setBottom(collided.getTop());
    }
    else if(s.change_y < 0)
    { 
      s.setTop(collided.getBottom());
    }
    s.change_y = 0;
  }
   
  s.center_x = s.center_x + s.change_x;
  collisions = checkCollisionList(s, object);
  if(collisions.size() > 0)
  { 
    World collided = collisions.get(0);
    if(collided.image == imageArray[2])
    {
      spikes = true;
    }
    if(collided.image == imageArray[1])
    {
      win = true;
      currentLevel++;
    }
    if(s.change_x > 0)
    { 
      s.setRight(collided.getLeft());
    }
    else if(s.change_x < 0)
    { 
      s.setLeft(collided.getRight());
    }
  }
}
