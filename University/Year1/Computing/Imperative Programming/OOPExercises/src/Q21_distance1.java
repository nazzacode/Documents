
public class Q21_distance1 {

	public static void main(String[] args) {
		int a = Integer.parseInt(args[0]);
		int b = Integer.parseInt(args[1]);
		
		int distance = Math.max(a, b) - Math.min(a,b);
		
		System.out.println(distance);
	}

}
