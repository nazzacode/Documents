# stdin.py
import sys

def read_in():
    return {x.strip() for x in sys.stdin}

def main():
    lines = read_in()
    for line in lines:
        print(line)

if __name__ == '__main__':
    main()
