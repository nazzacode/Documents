# Lab 3

# import packages
from queue import Queue, LL_Queue
from bufferio import BufferedInput, BufferedOutput

#Ex1
class CircBuffer_queue(Queue):
    def __init__(self, bufferSize):
        self.bufferSize = bufferSize
        self.buffer = [()] * bufferSize
        self.head = 0
        self.tail = 0
        self.full = False

    def isEmpty(self):        return (self.head == self.tail) and (not self.full)


    def push(self, x):
        if self.full:
            raise OverflowError("trying to push into a full circlar array")

        else:
            self.buffer[self.tail] = x
            self.tail = (self.tail + 1) % self.bufferSize
            if self.tail == self.head:
                self.full = True

    def pop(self):
        if self.isEmpty():
            raise IndexError("the queue is empty")
        else:
            y = self.buffer[self.head]
            self.head = (self.head + 1) % self.bufferSize
            self.full = False
            return y


def main():
    q = LL_Queue()
    print(q.isEmpty())
    q.push(1)
    print(q.isEmpty())
    q.pop()
    print(q.isEmpty())
    q.push(2)
    q.push(3)
    q.pop()
    print(q.isEmpty())
    q.push(4)
    q.pop()
    print(q.head)
    print(q.tail)


if __name__ == '__main__':
    main()
