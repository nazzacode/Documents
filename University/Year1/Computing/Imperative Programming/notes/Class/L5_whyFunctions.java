//Nathan Sharp
//23.01.19

//Lecture 5 - Why Functions?

modularity
//whenever you can clearly sperate tasks within programs you should do so

//functions should do ONE thing (and do that very well)

    //ANATOMY OF A JAVA FUNCTION

public static  double  distance     ( double x0, double y0,
                                    double x1, double y1) {
     double d1 = (x0 - x1);
     double d2 = (y0 - y1);
     return Math.sqrt(d1*d1 + d2*d2);

public static   // modifiers (research)
double          // return types
distance        // method name
double x0       // parameter type & parameter
double d1       // local variBLW

// call by value vs call by reference
//  - objects are reference?

    //SIGNATURE
//signature of a java function consists of its name an parameter list

    // NEAREST DOT - BREAKING DOWN code

// 1. parse arguemts (as corodinates)
// 2. get centre (base point)
// 3. print centre
// 4. get neibours
// 5. calculate distance
// 6. calculate minimim

//break into: parameters -> functions)

public static void main(String[] args) {
    double[] points = parseArguments(args);
    double[] centre = getCentre(points); printCentre(centre);
    double[] neighbours = getNeighbours(points);
    double[] distances = calcDistances(centre, neighbours); printDistances(distances, neighbours);
    double minimum = calcMinimum(distances); printMinimum(minimum); }

//showtime...

class NearestNeighbourBad {
    public static void main(String[] args) {
        int N = args.length;
        if (N % 2 != 0) N--; // ignore final arg if odd number
        double[] points = new double[N];

        for(int i = 0; i < N; i++)
            points[i] = Double.parseDouble(args[i]);

        double[] centre = { points[0], points[1] }; // first point is our centre
        System.out.printf("Centre lies at (%5.2f, %5.2f)\n", centre[0],         centre[1]);

        double[] neighbours = new double[points.length - 2];
        for(int i = 2; i < points.length; i++) // all except the first are
        neighbours neighbours[i - 2] = points[i];

        double[] dists = new double[neighbours.length / 2];
        for(int i = 0; i < neighbours.length; i += 2) { // step over two at a time to get x and y
        double d1 = centre[0] - neighbours[i];
        double d2 = centre[1] - neighbours[i + 1];
        dists[i / 2] = Math.sqrt(d1*d1 + d2*d2);
    }
    for(int i = 0; i < dists.length; i++)
        System.out.printf("Distance to (%5.2f, %5.2f) is %5.2f\n",          neighbours[(i*2)], neighbours[(i*2) + 1], dists[i]);

    double min = dists[0];
    for(int i = 1; i < dists.length; i++)
        if (dists[i] < min) min = dists[i];

    System.out.printf("Minimum distance to centre is %5.2f\n", min);
