#echo "L1 plus strand"
# ./01_filter_L1_discover.sh 41_1 1 $1 $2 $3
# ./02_somatic_L1.sh 41 1 $1 $2
#echo "L1 neg strand"
# ./01_filter_L1_discover.sh 41_0 1 $1 $2 $3
# ./02_somatic_L1.sh 41 0 $1 $2

#### titration ###
#echo "Alu plus strand"
# ./04_filter_Alu_discover.sh 40_1 2 $1 $2 $3
# ./05_somatic_Alu.sh 40 1 $1 2
#echo "Alu neg strand"
# ./04_filter_Alu_discover.sh 40_0 2 $1 $2 $3
# ./05_somatic_Alu.sh 40 0 $1 2

### merge NeuN- and NeuN+ ###
echo "L1 plus strand"
 ./01_filter_L1_Brain.sh 41_1 2 $1 $2 $3
echo "L1 neg strand"
 ./01_filter_L1_Brain.sh 41_0 2 $1 $2 $3

echo "Alu plus strand"
 ./04_filter_Alu_Brain.sh 42_1 2 $1 $2 $3
echo "Alu neg strand"
 ./04_filter_Alu_Brain.sh 42_0 2 $1 $2 $3
