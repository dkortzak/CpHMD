grep PROA system.pdb > proah.pdb
grep PROB system.pdb > probh.pdb
grep PROC system.pdb > proch.pdb
grep PROD system.pdb > prodh.pdb
grep PROE system.pdb > proeh.pdb
grep PROF system.pdb > profh.pdb
grep PROG system.pdb > progh.pdb
grep PROH system.pdb > prohh.pdb
grep PROI system.pdb > proih.pdb
grep POPC system.pdb > memb.pdb
sed -i '/TER  /d' memb.pdb


python noh.py

grep TIP3 system.pdb > bwat.pdb

sed -i '/TER  /d' bwat.pdb
sed -i 's/OH2 TIP /OH2 TIP3/g' bwat.pdb
sed -i 's/H1  TIP /H1  TIP3/g' bwat.pdb
sed -i 's/H2  TIP /H2  TIP3/g' bwat.pdb
sed -i 's/  0.00           /  0.00      TIP3 /g' bwat.pdb
sed -i "s/TIP3S/TIP3 /g" bwat.pdb
sed -i "s/SOLV/TIP3 /g" bwat.pdb
python sepwat.py
python sepmemb.py

for p in "a" "b" "c" "d" "e" "f" "g" "h" "i"; do
sed -i 's/HSE/HSP/g' pro${p}.pdb
sed -i 's/HSD/HSP/g' pro${p}.pdb
sed -i '/H.*HSP/d' pro${p}.pdb
done
#sed -i 's/  0.00           /  0.00      PROT /g' proa.pdb





python sepprot.py
mv proa1.pdb proa.pdb
mv prob1.pdb prob.pdb
mv proc1.pdb proc.pdb
mv prod1.pdb prod.pdb
mv proe1.pdb proe.pdb
mv prof1.pdb prof.pdb
mv prog1.pdb prog.pdb
mv proh1.pdb proh.pdb
mv proi1.pdb proi.pdb
grep CLA system.pdb > cla.pdb
grep SOD system.pdb > sod.pdb


python sepions.py
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
