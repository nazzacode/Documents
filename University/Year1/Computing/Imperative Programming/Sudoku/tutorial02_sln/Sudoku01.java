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

    /**
     * Print an ASCII representation of the game grid to the
     * console output.
     * @param grid the game grid to be printed
     */
    public static void printGrid(int[][] grid) {
        final int GRID_DIM = 9;
        final int SUBGRID_DIM = GRID_DIM / 3;

        for (int y = 0; y < GRID_DIM; y++) {
            for(int x = 0; x < GRID_DIM; x++) {
                System.out.print(grid[y][x]);
                if(x % SUBGRID_DIM == 2) System.out.print(" ");
                System.out.print(" ");
            }

            if(y % SUBGRID_DIM == 2) System.out.print("\n");
            System.out.print("\n");
        }
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

        boolean exit = false;
        while(!exit) {
            printMenu();
            int action = parseInput();
            int x,y,val;

            if(action == 1) {
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
            } else {
               System.out.println("Invalid input! Try again.");
            }
        }

    }
}
