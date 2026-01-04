grep PROA system.pdb > proah.pdb
grep POPC system.pdb > memb.pdb
grep TIP3 system.pdb > bwat.pdb
grep CLA system.pdb > cla.pdb
grep SOD system.pdb > sod.pdb

sed -i '/TER  /d' memb.pdb
sed -i '/TER  /d' bwat.pdb
sed -i 's/OH2 TIP /OH2 TIP3/g' bwat.pdb
sed -i 's/H1  TIP /H1  TIP3/g' bwat.pdb
sed -i 's/H2  TIP /H2  TIP3/g' bwat.pdb
sed -i 's/  0.00           /  0.00      TIP3 /g' bwat.pdb
sed -i "s/TIP3S/TIP3 /g" bwat.pdb
sed -i "s/SOLV/TIP3 /g" bwat.pdb
python noh.py

sed -i 's/HSE/HSP/g' proa.pdb
sed -i 's/HSD/HSP/g' proa.pdb
sed -i '/H.*HSP/d' proa.pdb


python sepwat.py
python sepmemb.py
python sepprot.py
python sepions.py


for p in "a" "b" "c" "d" "e" "f" "g" "h" "i"; do

done
#sed -i 's/  0.00           /  0.00      PROT /g' proa.pdb






mv proa1.pdb proa.pdb
mv prob1.pdb prob.pdb
mv proc1.pdb proc.pdb
mv prod1.pdb prod.pdb
mv proe1.pdb proe.pdb
mv prof1.pdb prof.pdb
mv prog1.pdb prog.pdb
mv proh1.pdb proh.pdb
mv proi1.pdb proi.pdb




mv sod1.pdb sod.pdb
mv cla1.pdb cla.pdb


for i in 1 2 3 4 5 6 7 8; do
    cp genpsf_wat1.inp genpsf_wat${i}.inp
    sed -i "s/wat1/wat"${i}"/g" genpsf_wat${i}.inp
    /home/danko/Downloads/charmm/charmm < genpsf_wat${i}.inp
    
done

#sleep 10m

for i in 1 2 3 4 5 6; do
    cp memb_genpsf.inp genpsf_memb${i}.inp
    sed -i "s/memb/memb"${i}"/g" genpsf_memb${i}.inp
    /home/danko/Downloads/charmm/charmm < genpsf_memb${i}.inp
done

/home/danko/Downloads/charmm/charmm < sod_genpsf.inp
/home/danko/Downloads/charmm/charmm < cla_genpsf.inp
k=0
for p in "a" "b" "c" "d" "e" "f" "g" "h" "i"; do
    cp build_partail_add_h_proa_noasp.inp build_partail_noasp${k}.inp
    sed -i "s/proa/pro"${p}"/g" build_partail_noasp${k}.inp
    k=$((k+1))
done
k=0
for p in "A" "B" "C" "D" "E" "F" "G" "H" "I"; do
    sed -i "s/PROA/PRO"${p}"/g" build_partail_noasp${k}.inp
    /home/danko/Downloads/charmm/charmm < build_partail_noasp${k}.inp
    k=$((k+1))
    

done
/home/danko/Downloads/charmm/charmm < step2_assemble_all.inp
parmed -i prmd
