import os
import subprocess
#give command to verilog
f = open("inpipe.txt", 'w')
f.writelines("1000")
f.close()

os.system('iverilog readfile.v -o file')
os.system('./file')
f = open("outpipe.txt", 'r')

#read result form verilog
print("new value is: " + f.readline())
f.close()
