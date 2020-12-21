import java.util.Arrays;

public class NbyN {
	
	public static int[][] nbyn(int N) {
		int[][] nbyn = new int[N][N];
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++ ) {
				if (i == j) { 
					nbyn[i][j] = i;
				}
				else {
					nbyn[i][j] = 0;
				}
			}
		}
		return nbyn;
	}
	public static void main(String[] args) {
		System.out.println(Arrays.deepToString(nbyn(9)));
		

	}

}
