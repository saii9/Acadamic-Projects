  /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Sunny
 *
 * Created on October 9, 2016, 1:35 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <mpi.h> /* Include MPI's header file */

/*
 * 
 */
 
const int numRow = 128;
const int numCol = 128;

void genMatrix(int* matx, int* maty){
    int i=0;
    int j=0;
    for (i=0; i<numRow; i++){
        for(j=0; j<numCol; j++){
            *(matx + 128*i + j) = j + 1;//rand()%1000;
            *(maty + 128*i + j) = j + 1;//rand()%1000;        
        }
    }
}

void printMat(int *resl){
    int i=0;
    int j=0;
    for (i=0; i<numRow; i++){
        for(j=0; j<numCol; j++){
             printf(" %d ", *(resl + 128*i + j));    
	}
             printf("\n");
    }
}

int main(int argc, char** argv) {
    int* matx, *maty;
    int myrank; /* The rank of the calling process */
    int npes;
    MPI_Status status;
    /* Initialize MPI and get system information */
    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &npes);
    MPI_Comm_rank(MPI_COMM_WORLD, &myrank);
    int nel = 128/npes;
    
    //printf("rank %d nel %d \n", myrank, nel);
    if (myrank == 0){
        matx = malloc(128 * 128 * sizeof(int));
        maty = malloc(128 * 128 * sizeof(int));
        genMatrix(matx, maty);
        // after generating send distribute the matrices to the processors
        // int MPI_Send(void *buf, int count,MPI_Datatype datatype, int dest, int tag,MPI_comm comm)
        int i;
        for (i = 1; i < npes; i++){
            //printf("send frm 0 to %d\n", i);
            MPI_Send((matx + 128 * i * nel), nel*128, MPI_INT, i, 0, MPI_COMM_WORLD);
            MPI_Send((maty + 128 * i * nel), nel*128, MPI_INT, i, 0, MPI_COMM_WORLD);
        }
    }else{
        matx = malloc(nel * 128 * sizeof(int));
        maty = malloc(nel * 128 * sizeof(int));
        //printf("recieve frm 0 to %d\n", myrank);
        //receive the matrices and store in an array
        MPI_Recv(matx, nel * 128, MPI_INT, 0, 0, MPI_COMM_WORLD, &status);
        MPI_Recv(maty, nel * 128, MPI_INT, 0, 0, MPI_COMM_WORLD, &status);    
    }
    
    // reduce the matrices x and y to x	if (myrank == 0){

    int i = 0, j = 0;
    for (i=0; i<nel; i++){
        for(j=0; j<numCol; j++){
            *(matx + 128*i + j) +=  *(maty + 128*i + j); //rand()%1000;        
        }
    }
    
	if (myrank == 0){
        for (i = 1; i < npes; i++){
            //printf("recv 0 after cmp %d \n", i);
            MPI_Recv((matx + 128 * i * nel), nel * 128, MPI_INT, i, 0, MPI_COMM_WORLD, &status);    
        }
        printMat(matx);
        free(matx);
        free(maty);
    }else{
        //printf("send to 0 after cmp %d \n", myrank);
        MPI_Send(matx, nel*128, MPI_INT, 0, 0, MPI_COMM_WORLD);
        free(matx);
        free(maty);
    }   
    MPI_Finalize();
    return (EXIT_SUCCESS);
}



