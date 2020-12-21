import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.Objects;

public class Sudoku01 {

    /**
     * Print a game menu message to the console.
     */
    public static void printMenu() {
        System.out.print("\n" +
                "1. Set field\n" +
                "2. Clear Field\n" +
                "3. Print Field\n" +
                "4. Exit\n\n" +
                "Select an action [1-4]: ");
    }   

    /**
     * Read a single integer value from the console and return it.
     * This function blocks the program's execution until a user
     * entered a value into the command line and confirmed by pressing
     * the Enter key.
     * @return The user's input as integer or -1 if the user's input was invalid.
     */
    public static int parseInput() {
        Scanner in = new Scanner(System.in);
        try {
            return in.nextInt();
        } catch (InputMismatchException missE) {
            in.next(); // discard invalid input
            return -1;
        }
    }   

    /**
     * Display a dialog requesting a single integer which is returned
     * upon completion.
     *
     * The dialog is repeated in an endless loop if the given input 
     * is not an integer or not within min and max bounds.
     *
     * @param msg: a name for the requested data.
     * @param min: minium accepted integer.
     * @param max: maximum accepted integer.
     * @return The user's input as integer.
     */
    public static int requestInt(String msg, int min, int max) {
        Objects.requireNonNull(msg);

        while(true) {
            System.out.print("Please provide " + msg + ": ");
            int input = parseInput();
            if (input >= min && input <= max) return input;
            else {
                System.out.println("Invalid input. Must be between " + min + " and " + max);
            }
        }
    }
    
    public static void gameLoop(int[][] grid, int min, int max) {
        boolean exit = false;
        while (!exit) {
        	printMenu();
            int action = parseInput();
            
            if (!(action >= min && action <= max)) {
                System.out.println("Invalid input. Must be between " + min + " and " + max);
            }
	        int x,y,val;
	        if (action == 1) {
	        	x = requestInt("x coordinate", 0, 8);
	            y = requestInt("y coordinate", 0, 8);
	            val = requestInt("field value", 1, 9);
	            grid[y][x] = val;
	            printGrid(grid);
	        } else if (action == 2) {
	        	x = requestInt("x coordinate", 0, 8);
	            y = requestInt("y coordinate", 0, 8);
	            grid[y][x] = 0;
	            printGrid(grid);
	        } else if (action == 3) {
	        	printGrid(grid);
	        } else if (action == 4) {
	        	exit = true; 
	        } 
        } 
   	}

    public static void printGrid(int[][] grid) {
    	for (int j = 0; j < 9; j++) {
    		if (j % 3 == 0) {
    			System.out.println();
    		}
    		for (int i = 0; i < 9; i++) {
    			if (i % 3 == 0) {
    				System.out.print("  ");
    			}
    			System.out.print(grid[j][i] + " ");
    		}
    		System.out.println();
    				
    	}
    }
    
    public static boolean checkRow(int[][] grid, int x, int y, int value) {
    	for (int i = 0; i < 9; i++) {
    		if (grid[i][y] == value); {
    			return false; 
    		}
    	}return true;
    }
        

    public static void main(String[] args) {
        int[][] grid = {
            {9,4,0,1,0,2,0,5,8},
            {6,0,0,0,5,0,0,0,4},
            {0,0,2,4,0,3,1,0,0},
            {0,2,0,0,0,0,0,6,0},
            {5,0,8,0,2,0,4,0,1},
            {0,6,0,0,0,0,0,8,0},
            {0,0,1,6,0,8,7,0,0},
            {7,0,0,0,4,0,0,0,3},
            {4,3,0,5,0,9,0,1,2}
        };
		//System.out.println(checkRow(grid, 2, 1, 5));
        printGrid(grid);
        gameLoop(grid, 1, 4);
        
       
        

    }
}
