import java.util.Scanner;
import java.util.InputMismatchException;
import java.util.Objects;

public class Sudoku01Ext { 

    /**
     * Print a game menu message to the console.
     */
    public static void printMenu() {
        System.out.print("\n" +
		"1. Set field\n" +
		"2. Clear field\n" +
        "3. Print game\n" +
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

    public static void setField(int[][] grid) {
	    int x = requestInt("x coordinate", 1, 9);
	    int y = requestInt("y coordinate", 1, 9);
	    int v = requestInt("value", 1, 9);
	    grid[y - 1][x - 1] = v;
    }

    public static void clearField(int[][] grid) {
	    int x = requestInt("x coordinate", 1, 9);
	    int y = requestInt("y coordinate", 1, 9);
	    grid[y - 1][x - 1] = 0;
    }

    public static void printGrid(int[][] grid) {
	System.out.println("  1 2 3 4 5 6 7 8 9");
	System.out.println(" ╭─────┬─────┬─────╮");
    	for (int y = 0; y < grid.length; y++) {
		if (y % 3 == 0 && y > 0)
			System.out.println(" ├─────┼─────┼─────┤");
		System.out.print(Integer.toString(y + 1) + "│");
		for (int x = 0; x < grid[0].length; x++) {
			if (x % 3 == 0 && x > 0)
				System.out.print("│");
			System.out.print(Integer.toString(grid[y][x]));
			if (x != 2 && x != 5 && x != 8)
				System.out.print(" ");
		}
		System.out.println("│");
	}
	System.out.println(" ╰─────┴─────┴─────╯");
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

	    printGrid(grid);

	    while (true) {
	    	printMenu();
	    	int entry = requestInt("entry", 1, 4);
	    	switch (entry) {
	    		case 1: setField(grid);
	    		        printGrid(grid);
	    			break;
	    		case 2: clearField(grid);
	    			printGrid(grid);
	    			break;
	    		case 3: printGrid(grid);
	    			break;
	    		case 4: return;
	    	}

	    }

    }
}
