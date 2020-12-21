#![allow(unused_imports)]
use std::collections::{HashMap, HashSet};
use std::cmp::{max, min};
use std::io::{self, Write};
use std::str;

struct Scanner<R> {
    reader: R,
    buf_str: Vec<u8>,
    buf_iter: str::SplitAsciiWhitespace<'static>,
}
impl<R: io::BufRead> Scanner<R> {
    fn new(reader: R) -> Self {
        Self {
            reader,
            buf_str: Vec::new(),
            buf_iter: "".split_ascii_whitespace()
        }
    }
    fn token<T: str::FromStr>(&mut self) -> T {
        loop {
            if let Some(token) = self.buf_iter.next() {
                return token.parse().ok().expect("Failed parse");
            }
            self.buf_str.clear();
            self.reader
                .read_until(b'\n', &mut self.buf_str)
                .expect("Failed read");
            self.buf_iter = unsafe {
                let slice = str::from_utf8_unchecked(&self.buf_str);
                std::mem::transmute(slice.split_ascii_whitespace())
            }
        }
    }
}

fn main() {
    let (stdin, stdout) = (io::stdin(), io::stdout());
    let mut scan = Scanner::new(stdin.lock());
    let mut out = io::BufWriter::new(stdout.lock());

    let t = scan.token::<usize>();
    for _ in 0..t {
        let n = scan.token::<usize>();
        let mut d = scan.token::<usize>();

        let mut ans = scan.token::<usize>();
        for j in 1..n {
            let a = scan.token::<usize>();
            let m = min(a, d / j);
            d -= m * j;
            ans += m;
        }
        writeln!(out, "{}", ans).ok();
    }
}

#[cfg(test)]
mod tests {
    #[test]
    fn example1() {
        input =
        assert_eq!(, )
    }
}

