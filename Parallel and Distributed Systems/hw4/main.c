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
#include <time.h>
#include <pthread.h>

/*
 * 
 */
const int numThreads = 8;
const int numRow = 128;
const int numCol = 128;
int numExit = 8;

int *res;
int *matx;
int *maty;

pthread_cond_t bSignal;
pthread_mutex_t condMutex;

void genMatrix(){
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

void* process(void* ptr){
    int i=0, j=0;
    int thNum = *((int*)ptr);
    //printf("processing %d\n", thNum);
     for (i= 16 * thNum; i <= 16 * thNum + 15; i++){
         for(j=0; j<numCol; j++){
            *(res + 128*i + j) = *(matx + 128*i + j) + *(maty + 128*i + j);
         }
     }
     while(1){
         //printf("llllll %d numexit %d\n", thNum, numExit);
         pthread_mutex_lock(&condMutex);
         //printf("thread %d numexit %d\n", thNum, numExit);
         if(thNum +1 == numExit){
            numExit--;
            printf("Thread %d : done \n", thNum);
            pthread_mutex_unlock(&condMutex);
            pthread_cond_broadcast(&bSignal);
            return;
        }

         pthread_cond_wait(&bSignal, &condMutex);
          //printf("Thread blocked %d\n", thNum);
         pthread_mutex_unlock(&condMutex);
     }
}

int main(int argc, char** argv) {

	res = malloc(128 * 128 * sizeof(int));
	matx = malloc(128 * 128 * sizeof(int));
	maty = malloc(128 * 128 * sizeof(int));
    
    genMatrix();
   
    pthread_mutex_init(&condMutex,NULL);
    pthread_cond_init(&bSignal,NULL);
    pthread_t th[numThreads];
    int i =0 ;
    for(i =0; i< numThreads; i++){
        int *thNum = malloc(sizeof(int));
        *thNum = i;
        pthread_create(&th[i], NULL, process, thNum);
    }
    for(i =0; i< numThreads; i++){
        pthread_join(th[i], NULL);
    }
    printf("Final Matrix\n");
    printMat(res);
    return (EXIT_SUCCESS);
}


