#![allow(unused_imports)]
use std::cmp::{max, min};
use std::collections::{HashMap, HashSet};
use std::fs;
use std::io::{self, Write};
use std::process::{Command, Stdio};
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
            buf_iter: "".split_ascii_whitespace(),
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
        let x = scan.token::<i64>();

        let mut ans = x + 1;
        for _ in 0..n {
            let a = scan.token::<i64>();
            if a == x {
                ans = 1;
            }
            ans = min(ans, max(2, (x + a - 1) / a));
        }
        writeln!(out, "{}", ans).ok();
    }
}

#[cfg(test)]
mod tests {

    use std::process::{Command, Stdio};
    use std::str;

    #[test]
    fn example1() {
        // let input = fs::read_to_string(b_input.txt).expect("Failed Read");
        let _cat_child = Command::new("cat")
            .arg("src/b_input.txt")
            .stdout(Stdio::piped())
            //.spawn()
            .output()
            .expect("Failed to Execute command");

        // let cat_out = cat_child.stdout;
        println!("{:?}", "HELLLOOO");

        let run_child = Command::new("cat")
            //.current_dir("./../../..")
            .stdin(Stdio::piped())
            .output()
            .expect("Failed to run program");

        let run_out = run_child.stdout;

        assert_eq!("2\n3\n1\n2", str::from_utf8(run_out.as_slice()).unwrap());
    }
}
