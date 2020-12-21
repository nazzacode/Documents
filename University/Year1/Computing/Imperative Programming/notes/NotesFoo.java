//THE MAGIC INCANTATION
public static void main( String[] args ) {

// ---------- CONTROL FLOW ---------- //

//LOOPS
//rule of thumb: if you know the iteration count use for, if not, use while.

// FOR LOOP
for (init; boolean expression; increment) {
    statement 1;
    statement 2;
}
//shorthand wizardry
for (case : in) {}

//SWITCH
//byte, short, char, int data types.
switch (case) {
    case 1: statement 1;
        break;
    case 2: statement 2;
        break;
}

//DO-WHILE
//reverses the order of while block so statment is evaluated first
do {
        statement(s)
    } while (expression);

//BREAK
//(unlabeled) terminates the innermost statement, (labeled) see below
search:
       for (i = 0; i < arrayOfInts.length; i++) {
           for (j = 0; j < arrayOfInts[i].length;
                j++) {
               if (arrayOfInts[i][j] == searchfor) {
                   foundIt = true;
                   break search;


//CONTINUE
//skips the rest of a current itteration of a loop

//CLASS ANATOMY
public class Circle {
    private double radius; //instance variable decl. (automaticially intitalised)
    //constructor declarations look like method declarations but have the neame of the class and no return type
    public Circle(double newRadius) { //constructor (circle: constructor name)
        radius = newRadius; // instance variable
    }
    public double getArea() { //instance method
        return radius * radius * Math.PI;
    }
}

//ACCESS MODIFIERS
Modifier    class   package global
Public      yes     yes     yes
Default     yes     yes     no
Private     yes     no      no

//STRINGS
.charAt(index)
.chars() //returns stream of chars
.contains() //could be a char or string
.indexOf() //can be substring
.length()
.replace(oldchar, newchar) //replaces all occurences
.toLowerCase()
.toUpperCase()
.toCharArray()
.trim() //removes whitespace
.valueOf //returns string representation boolean,char,char[], obj...

//ARRAYS
String[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
int[][] //multidimentional array
myarr[3] // elements acessed by bracket notation (rather than dots)

java.unit.Arrays //dis yourhomeboy
myarr.length
Arrays.toString(myarr) //PRINTING
Arrays.deeptToString(myarr) //for multidim arrays
Arrays.arraycopy() //copies shit
.asList()
copOfRange(array, from, to) //do not need to create a destination as returned by method
sort() //puts into accending order
binarySearch() //searches for value and returns its index
equals() //compares two arrays to see if equal
fill() //places a specific value at each index

//COLLECTIONS (list, map, set)
.add()
.remove(o)
.addAll(Collection)
.contains()
.isEmpty()
.toArray(T[] a)
.retainAll(Collection) //retain only the element contained in this collection
.clear() //remove all elements from this collection
.reverseOrder()
.reverse()
.rotate(collection, int)
.sort()

//SETS - like lists but cant contain duplicate elements
Set<wrapper> set = new HashSet<>();
java.util.Set

//LISTS - ordered collections aka sequence
//dont need to predeclare size
List a = new ArrayList();
List b = new LinkedList();
List c = new Vector();
List d = new Stack();

java.util.List
.add(int idex, elem)
.get(index)
.set(index, new)
.indexOf()
.sublist(fromIndex, toIndex)
.contains(object)
.clear()
.isEmpty()
.size()
.sort() //eh?
.toArray()

//ARRAYLIST - class subtype of list
java.util.ArrayList
ArrayList<type> myArrList = new ArrayList<type>()
.toArray()

HashMap
LinkedHashMap






//ITERATOR & LISTITERATOR
Iterator itr = mylist.iterator();

java.util.Iterator
.hasNext() //true if has more elements
.next()
.remove()

java.util.listIterator
.nextIndex() //returns index of next element
.previous()
.hasPrevious()
.previousIndex()
.set(ojb) //replaces last element returned
.add(obj) //inserts in position before element


//EQUALS ( a == b vs. a.equals(b))
//objects compare instances (position in memmory), primatives compare value
.equals //to stay on the safe size and compare states not instancea

//FORMATTING
source -> format //magically improves indentation & spacing
refactor (->) rename // repaces all instances of x with y

//FORMAT SPECIFIERS
String.format(string format, object ... args)
System.out.format() //prints format style

// Specifier   Data Type       Output
//
// %a          floating p.      hex output
// %b          any             "true" if !null "false" otherw.
// %c          character       unicode character
// %d          integer         decimal integer
// %e          floating p      decimal number in scientific notation
// %f          floating p.     decimal number
// %g          floating p.     fuck knows
// %h          any             hex string value (hash code)
// %n          none            platform specific line separator
// %o          integer         octal number
// %s          any type        string value
// %t          date/time       date/time conversion
// %x          integer         hex string

//how to put in decimal notation

//needs work!

// SPECIAL CHARACTERS
    \b //backspace
    \t //tab
    \n //new line
    \f //from feed
    \r //carriage return
    \" //double quote "
    \' //single quote '
    \\ //backslash

//CONDITIONAL OPERATORS
&& // AND
||  // OR
?: // if then else shorthand operator
someCondition ? value1 : value2
//(if) someCondition ? (is true) (assign the value) value1 : (else) value2;

//THIS
//point class
public class Point {
    public int x = 0;
    public int y = 0;

public Point(int x, int y) {
    this.x = x;
    this.y = y;
}

//INHERITANCE
public class PGStudent extends Student { ...
}

super //calles overridden method from superclass

//ERRORS

throw new IllegalArgumentException("...")
Objects.requireNonNull(object)



DecimalFormat df = new DecimalFormat("#,###.##");
df.format(mynumber)

Math.round(val*100) /100




null pointer exeption //you have referenced a non-initialised varable


//STREAM
java.until.stream
d.stream() //start with this
.filter(x = x)
.map(x -> f(x))
.flatMap()  //produces stream rather than input elements
.sorted()
.summary() //ints to give {count, sum, min, avg, max}


.reduce() //like a fold
.sum() = .reduce(0 (x,y) -> x+y) //reduce
.distinct()  //removes non destinct items
.count()
.max()
.min()
.average()
.allMatch(predicate)
.anyMatch(predicate)

.forEach() //(System.out::print)
.forAny()
.collect() // Collectors.asList, Collectors.joining(", ")

.toArray(size -> new Integer[size])
.toArray(int[][]::new)

.mapToInt(x -> x) //if you dont want int[]

String str -> Integer.parseInt(str)

Arrays.stream(arr)
//returns IntStream
//only worlks for primative types

Stream.of(arr)
//returns Stream<Integer>
//generic (wrapper of arrays.stream)
//needs flattening

//COMPARITOR - external controllable ordering
public static Comparator<Contact> COMPARE_BY_PHONE = new Comparator<Contact>() {
        public int compare(Contact one, Contact other) {
            return one.phone.compareTo(other.phone);
        }
//OR
Collections.sort(people, (a, b) -> a.age < b.age ? -1 : a.age == b.age ? 0 : 1);
// 1 if rhs before lhs,
//-1 if lhs before rhs
//0 0 otherwise
//equivalent of lhs-rhs
