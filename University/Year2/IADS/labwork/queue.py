# queue.py

import abc

class Queue(abc.ABC):

    @abc.abstractmethod
    def isEmpty(self):
        pass

    @abc.abstractmethod
    def push(self,x):
        pass

    @abc.abstractmethod
    def pop(self):
        pass

# single unit of a linked list built from queue abstract data type
class LL_Queue(Queue):

    def __init__(self):
        self.tail = [()]
        self.head = self.tail


        return self.head[0] == ()


    def push(self, x):
        self.tail[0] = (x, [()])
        self.tail = self.tail[0][1]


    def pop(self):
        if self.isEmpty():
            raise IndexError
        else:
            y = self.head[0][0]
            self.head = self.head[0][1]
            return y




