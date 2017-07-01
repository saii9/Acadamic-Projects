gcc -fopenmp -lm -o main main.c

bash -c "export  OMP_NUM_THREADS=1; ./main 8 >  data8.log"
bash -c "export  OMP_NUM_THREADS=2; ./main 8 >> data8.log"
bash -c "export  OMP_NUM_THREADS=4; ./main 8 >> data8.log"
bash -c "export  OMP_NUM_THREADS=8; ./main 8 >> data8.log"


bash -c "export  OMP_NUM_THREADS=1; ./main 10 >  data10.log"
bash -c "export  OMP_NUM_THREADS=2; ./main 10 >> data10.log"
bash -c "export  OMP_NUM_THREADS=4; ./main 10 >> data10.log"
bash -c "export  OMP_NUM_THREADS=8; ./main 10 >> data10.log"

bash -c "export  OMP_NUM_THREADS=1; ./main 12 >  data12.log"
bash -c "export  OMP_NUM_THREADS=2; ./main 12 >> data12.log"
bash -c "export  OMP_NUM_THREADS=4; ./main 12 >> data12.log"
bash -c "export  OMP_NUM_THREADS=8; ./main 12 >> data12.log"

bash -c "export  OMP_NUM_THREADS=1; ./main 14 >  data14.log"
bash -c "export  OMP_NUM_THREADS=2; ./main 14 >> data14.log"
bash -c "export  OMP_NUM_THREADS=4; ./main 14 >> data14.log"
bash -c "export  OMP_NUM_THREADS=8; ./main 14 >> data14.log"

