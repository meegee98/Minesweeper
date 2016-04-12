import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs= new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
public final static int NUM_ROWS = 20;
public final static int NUM_COLS=20;
//bombs=new ArrayList <MSButton> ();
void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here

    buttons= new MSButton[NUM_ROWS][NUM_COLS];
    for(int row=0; row<20; row++)
    {
      for(int col =0; col<20; col++)
        buttons[row][col]= new MSButton(row,col);
    }
    for(int i=0; i<50; i++) //50 bombs
        setBombs();
}
public void setBombs()
{  
        int row=(int)(Math.random()*NUM_ROWS) ;
        int col=(int)(Math.random()*NUM_COLS);
        if(!bombs.contains(buttons[row][col]))
        {
            bombs.add(buttons[row][col]);
            
        } 
        else {
            setBombs();           
        }
}
// 30 bombs
public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    /*for(int row=0; row<NUM_ROWS; row++)
        for(int col=0; col<NUM_COLS; col++)
            if(bombs.contains[row][col])
                return false;*/
    return false;
}
public void displayLosingMessage()
{
    
    for(int i=0; i<bombs.size(); i++)
    {
        (bombs.get(i)).setClicked(true);
    }
    buttons[2][5].setLabel("Y");
    buttons[2][6].setLabel("O");
    buttons[2][7].setLabel("U");
    buttons[2][8].setLabel("");
    buttons[2][9].setLabel("L");
    buttons[2][10].setLabel("O");
    buttons[2][11].setLabel("S");
    buttons[2][12].setLabel("E");

    buttons[3][4].setLabel("T");
    buttons[3][5].setLabel("R");
    buttons[3][6].setLabel("Y");
    buttons[3][7].setLabel("");
    buttons[3][8].setLabel("A");
    buttons[3][9].setLabel("G");
    buttons[3][10].setLabel("A");
    buttons[3][11].setLabel("I");
    buttons[3][12].setLabel("N");
    buttons[3][13].setLabel("!");
}
public void displayWinningMessage()
{
    buttons[2][8].setLabel("W");
    buttons[2][9].setLabel("I");
    buttons[2][10].setLabel("N");
    buttons[2][11].setLabel("N");
    buttons[2][12].setLabel("E");
    buttons[2][13].setLabel("R");

    buttons[3][8].setLabel("P");
    buttons[3][9].setLabel("L");
    buttons[3][10].setLabel("A");
    buttons[3][11].setLabel("Y");
    buttons[3][12].setLabel("");
    buttons[3][13].setLabel("A");
    buttons[3][14].setLabel("G");
    buttons[3][15].setLabel("A");
    buttons[3][16].setLabel("I");
    buttons[3][17].setLabel("N");

    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
        //flags the button
    }
    public boolean isClicked() 
    {
        return clicked;
        //makes button light gray background/ OPENS BUTTON
    }
    public void setClicked(boolean nClick)
    {
        clicked=nClick;
    }
    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton== RIGHT && label.equals(""))
            {marked=!marked;
            clicked = false;}
        else if(bombs.contains(this))
            displayLosingMessage();
        else if(countBombs(r,c)>0)
            setLabel(""+countBombs(r,c)); //"" makes int a string
        else 
        {
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked()) 
            buttons[r][c-1].mousePressed();

          if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();
            
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();

          if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();

          if(isValid(r-1, c-1) && !buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();

          if(isValid(r+1, c-1) && !buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();

          if(isValid(r-1, c+1) && !buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();

          if(isValid(r+1, c+1) && !buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();

            /*for(int rr = -1; rr < 2; rr++) 
            {
                for(int cc = -1; cc < 2; cc++) 
                {
                    if(isValid(r+rr,c+cc) && !buttons[r+rr][c+cc].isClicked())
                        buttons[r+rr][c+cc].mousePressed();
                }
            }*/
        }  
    }
    public void draw () 
    {    
        if (marked)
            fill(0);
        else if(clicked && bombs.contains(this)) 
             fill(255,0,0);
        else if(clicked) {
            fill(200);
        }
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>-1 && r<NUM_ROWS && c>-1 && c<NUM_COLS)
            return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if(isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
            numBombs++;
        if(isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
            numBombs++;
        if(isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
            numBombs++;
        if(isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
            numBombs++;

        if(isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
            numBombs++;
        if(isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
            numBombs++;
        if(isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
            numBombs++;
        if(isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
            numBombs++;

        /*for(int rr = -1; rr < 2; rr++) {
            for(int cc = -1; cc < 2; cc++) {
                if(isValid(row+rr,col+cc) && bombs.contains(buttons[row+rr][col+cc]) && row+rr != 0 && col+cc !=0) 
                    numBombs++;
            }
        }*/
        return numBombs;
    }
}





