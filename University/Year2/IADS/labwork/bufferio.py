# buffered read/write
# structures that read or write files in chunks #
class BufferedInput:
    def __init__(self,filename,memory):
        self.reader = open(filename, 'r', encoding='utf-8')
        self.buffer = self.reader.readlines(memory)
        self.memory = memory
        self.pos = 0


    def readline(self):
        if self.buffer == []:
            return ''
        else:
            result = self.buffer[self.pos]
            sef.pos += 1
            if self.pos == len(self.buffer):
                self.buffer = self.reader.readlines(self.memory)
                self.pos = 0
            return result


    def close(self):
        self.reader.close()


class BufferedOutput:
    def __init__(self, filename,size):
        self.writer = open(filename, 'w', encoding='utf-8')
        self.buffer = ['' for i in range(size)]
        self.lines = size
        self.pos = 0


    def writeline(self, str):
        self.buffer[self.pos] = str
        self.pos += 1
        if self.pos == self.lines:
            self.writer.writelines(self.buffer)
            self.pos = 0

    # flushes buffer and closes he file
    def flush(self):
        self.writer.writelines(self.buffer[0:self.pos])
        self.writer.close()
