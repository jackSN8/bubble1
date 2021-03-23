function setup()
{

}

function draw()
{

}

class life
{
  constructor(size,color,position)
  {
    this.size = size;
    this.color = color;
    this.position = position;
  }
  display()
  {
    fill(this.color);
    circle(this.position.x,this.position.y,this.size);
  }
}

class food extends life
{
  constructor(size,color,position)
  {
    super(size);
    super(color);
    super(position);
  }
}
