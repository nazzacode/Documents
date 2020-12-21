
# program to test the time implementations of different circular buffers in python


# implementation 1: Basic array

class CircularBuffer1:
    def __init__(self,size):
        self.size = size
        self.buffer = [None for i in range(size)]

    def push(self,x):
        self.buffer.pop(0)
        self.data.append(x)

    def get(self):
        return self.buffer


# implementation 2: Lab

class CircularBuffer2:
    def __init__(self,size):
        self.size = size
        self.buffer = [()] * size
        self.head = 0
        self.tail = 0
        self.full = False

    def push(self,x):
        self.buffer[self.tail] = x
        self.tail = (self.tail + 1) % self.size
        if self.tail == self.head:
            self.full = True

    def get(self):
        return self.buffer

# implementation 3: deque

from collections import deque





