


for c in ["a","b","c","d","e","f","g","h","i"]:

    in1=tuple(open(f"pro{c}h.pdb"))
    out=open(f"pro{c}.pdb","w")




    for i in range(0,len(in1)):
        line=in1[i]
        if " H" in line:
            if "HSE" not in line:
                continue
            else:
                out.write(line)
        else:
            out.write(line)
    out.close()
