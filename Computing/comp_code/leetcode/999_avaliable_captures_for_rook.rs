impl Solution {
    pub fn find_rook(board: &Vec<Vec<char>>) -> (usize, usize) {
        for (y, row) in board.iter().enumerate() {
            for (x, piece) in row.iter().enumerate() {
                if *piece == 'R' {
                    return (x, y);
                }
            }
        }
        unreachable!()
    }

    pub fn rules<'a, I>(direction: I) -> i32
    where
        I: IntoIterator<Item = &'a char>
    {
        direction
            .into_iter()
            .skip_while(|piece| **piece == '.')
            .next()
            .map_or(0, |piece| if *piece == 'p' { 1 } else { 0 })
    }

    pub fn num_rook_captures(board: Vec<Vec<char>>) -> i32 {
        let (x, y) = Self::find_rook(&board);
        let mut count = 0;

        count += Self::rules(board[y][x + 1..].iter()); //east
        count += Self::rules(board[y][..x].iter().rev()); //west
        count += Self::rules(board[..y].iter().map(move |row| &row[x]).rev()); //n
        count += Self::rules(board[y + 1..].iter().map(move |row| &row[x])); //south

        return count;
    }
}
