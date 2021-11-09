import os
import subprocess
#give command to verilog
f = open("inpipe.txt", 'w')
f.writelines("1000")
f.close()
#subprocess.run(["./file"])
os.system('iverilog readfile.v -o file')
os.system('./file')
f = open("outpipe.txt", 'r')

print("new value is: " + f.readline())