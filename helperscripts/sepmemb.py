import numpy as np
in1=tuple(open("memb.pdb"))



N=len(in1)
off=0
if "CRYST" in in1[0]:
    off=1
n=0
l=1

print(n,off)
first=True
while np.min([29882,N-n])!=0 or first:
    first=False
    n=n+np.min([29882,N-n])
    out1=open(f"memb{l}.pdb","w")
    print(off,n,N)
    loff=""
    
    for i in range(off,n):
        loff=""
        if i-off+1<10000:
            loff=" "
        if i-off+1<1000:
            loff="  "
        if i-off+1<100:
            loff="   "   
        if i-off+1<10:
            loff="    "        
        j=(int((i-off)/134))+1 
        loff0=""
        if j<10000:
            loff0=" "
        if j<1000:
            loff0="  "
        if j<100:
            loff0="   "
        if j<10:
            loff0="    "

        out1.write(in1[i][:6]+loff+str(i-off+1)+in1[i][11:21]+loff0+str(j)+in1[i][26:])
         
    out1.write("TER\n")
    out1.close()
    l=l+1
    #n=n+99999
    off=off+29882
print(in1[-1],i,in1[i])

