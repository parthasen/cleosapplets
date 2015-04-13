Program by Cleophus Robinson IV

To compile execute the command
javac -cp .:acm.jar Breakout.java

To run the applet execute the comman
java -cp .:acm.jar Breakout

/*
 * Use space to toggle the pause button
 * Press s to toggle the sound
 * Press g for god mode
 * Press f for a faster ball
 * Press d for a slower ball
 * Press r for a longer paddle
 * Press e for a shorter paddle
 */

/*
 * Future extensions, more balls (keep all balls in an array and call move on each one)
 * Keep all objects that arent a brick, ball or paddle (anything a ball shouldnt react too) 
 * -in an array for easier collision elimination
 * Implement powerups, keep in a seperate object array
 * Invert the colors on the board, keep track of all objects colors. If its a brick just change
 * -the color array.
 * Implement levels, a help menu, highscore save, and quitting
 * Implement better collision detection and allow the paddle to add or take away speed from balls
 */

/* Bugs
 *
 * I dont like how the ball bounces off the paddle
 * The screen is never the correct size when it starts
 */ 