
//LECTURE 8

//Packages


//String package


//Class Anatomy

public class Circle {
    private double radius; //instance variable decl. (automaticially intitalised)

    public Circle(double newRadius) { //constructor (circle: constructor name)
        radius = newRadius; // instance variable
    }
    public double getArea() { //instance method
        return radius * radius * Math.PI;
    }
}

/*
Summary We looked at:
- using client programs to motivate our classes, and to test them
    instance variables:
- represent data that is particular to an object (i.e., an instance!); I have scope over the whole class;
- can hold mutable state;
- can be manipulated by any instance method in the class.
    instance methods:
- like static methods, but can only be called on some object o;
- have access to the data that is speciﬁc to o. I constructors:
- we create a new object of class Foo with the keyword new;
- we initialise an object of type Foo by calling the constructor for that type; - the constructor is used to store data values
*/

//HOTEL RESERVATION SYSTEM

//every instance member should be private for now
//use final for variables that never change after initial assinginment


//CLASS - VERSION 1

public class HotelRoom {
    private final int roomNumber;
    private int roomRate;

    public HotelRoom(int num, int rate){
        roomNumber = num;
        roomRate = rate;
    }
    public boolean isAvailable(int startDate, int duration){
         return true;
     }
 }

//ENCAPSULATION

//hiding data behind a we defined interface
//keeps data representation hidden with 'private' acsess modifier


//ACCESS MODIFIERS

Modifier    class   package global
Public      yes     yes     yes
Default     yes     yes     no
Private     yes     no      no
