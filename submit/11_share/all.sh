sbatch ./00_MERG_BulkSeq.sh 41_1 fetal LINE 1
sbatch ./00_MERG_BulkSeq.sh 41_0 fetal LINE 0
sbatch ./00_MERG_BulkSeq.sh 42_1 fetal ALU 1
sbatch ./00_MERG_BulkSeq.sh 42_0 fetal ALU 0

sbatch ./00_MERG_BulkSeq.sh 41_1 adult LINE 1
sbatch ./00_MERG_BulkSeq.sh 41_0 adult LINE 0
sbatch ./00_MERG_BulkSeq.sh 42_1 adult ALU 1
sbatch ./00_MERG_BulkSeq.sh 42_0 adult ALU 0

sbatch ./00_MERG_Texan.sh 41_1 10011 LINE 1
sbatch ./00_MERG_Texan.sh 41_0 10011 LINE 0
sbatch ./00_MERG_Texan.sh 42_1 10011 ALU 1
sbatch ./00_MERG_Texan.sh 42_0 10011 ALU 0

sbatch ./00_MERG_Texan.sh 41_1 12004 LINE 1
sbatch ./00_MERG_Texan.sh 41_0 12004 LINE 0
sbatch ./00_MERG_Texan.sh 42_1 12004 ALU 1
sbatch ./00_MERG_Texan.sh 42_0 12004 ALU 0

sbatch ./00_MERG_Texan.sh 41_1 11003 LINE 1
sbatch ./00_MERG_Texan.sh 41_0 11003 LINE 0
sbatch ./00_MERG_Texan.sh 42_1 11003 ALU 1
sbatch ./00_MERG_Texan.sh 42_0 11003 ALU 0

sbatch ./00_MERG_Texan.sh 41_1 11004 LINE 1
sbatch ./00_MERG_Texan.sh 41_0 11004 LINE 0
sbatch ./00_MERG_Texan.sh 42_1 11004 ALU 1
sbatch ./00_MERG_Texan.sh 42_0 11004 ALU 0
