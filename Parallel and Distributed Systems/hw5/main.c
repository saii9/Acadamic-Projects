#include <stdio.h>
#include <omp.h>// compile with: /openmp
#include <stdlib.h>
#include <math.h>

int OMP_NUM_THREADS;    
int power=3;


int readArgs(int argc, char **argv){
    char *envVal;
    envVal = getenv("OMP_NUM_THREADS");

    if (envVal != NULL) {
        OMP_NUM_THREADS =atoi(envVal);
       // printf("num threads : %d\n",OMP_NUM_THREADS);
    }else{
    	printf("the number of theads is not set. exiting \n");
	return(1);
    }
    if (argc != 2){
	printf("usage : ./main <provide power of size of the array> \n");
        return 2;
    }else{
        power = atoi(argv[1]);    
        if(power > 20) {
            printf("choose power less than 20 \n");
            return(3);
        }
    }
    return 0;
}


int main(int argc, char **argv) {
    if(readArgs(argc, argv)) return(1);
    int i = 0;
    int ne = pow(2, power);
    int* a = malloc(ne * sizeof(int));
    int* ta = malloc(ne * sizeof(int));
    int* temp;
    for(i = 0; i<ne; i++ ){
            a[i] = i;
                //printf(" a[%d] = %d\n", i , a[i]);
    }
    //printf("array size : %d\n", ne);
    int j = 0; 

    double ts =0, tt=0;
    ts = omp_get_wtime();
    for (j = 0; j < power; j++){
        //memcpy(ta, a, ne * sizeof(int));
        temp = ta;
        ta = a;
        a = temp;
        int shift = pow(2, j);
        //printf("%d shift %d\n",omp_get_thread_num(), shift);
        int k = 0;
       #pragma omp parallel
       {
            #pragma omp for 
            for(k = 0 + shift; k < ne; k++){
                if (k < shift) a[k] = ta[k];
                else{
                //printf(" thread %d adding [%d , %d] val [%d , %d]\n", omp_get_thread_num(), k, k-shift, a[k], a[k-shift]);
                a[k] = ta[k] + ta[k - shift];	
                }
            }
        }
    }
    tt += omp_get_wtime() - ts;
        
    printf("%d %.16g\n",OMP_NUM_THREADS, tt * 1000000);
    //printf("Sum  %d\n", a[ne - 1]);
}