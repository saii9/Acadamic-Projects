/*
 * author: Sundeep Innamuri, student id: 004507888
 * for : parallel and dritributed systems , homework 1
 * Created on September 17, 2016, 3:41 PM
 * 
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
/* 
 * 
 *  
 */

// intializing the global variables
int numCities = 0;
int **disMat;
int **permutations;

//to find the possible permutations
void findPermutations(int inputSize){
	int *c = malloc(sizeof(int) * inputSize);
	int *o = malloc(sizeof(int) * inputSize);
	int *a = malloc(sizeof(int) * inputSize);
	int count = 0;
	permutations = malloc(sizeof(int*) * (count+1));

	//printf("step 1 \n");
	int i = 0	;
	for (i = 0; i < inputSize; i++){
		c[i] = 0;
		o[i] = 1;
		a[i] = i;
	}

	while(1){
		//printf("step 2 \n");
		int *seq = malloc((sizeof(int) * numCities));
		memcpy(seq, a, sizeof(int) * inputSize);	
		permutations = (int**)realloc(permutations, sizeof(int*) * ++count);
		*(permutations + count - 1) = seq;
		int j = inputSize - 1;
		int s = 0;
		int q;
		while(1){
		//printf("step 4 \n");
			q = c[j] + o[j];
			if( q < 0){
				//got to S7
				//printf("step 7 \n");
				o[j] = -1 * o[j];
				j = j - 1;
				//go to S4
			}else if( q == j ){
				//go to S6
				//printf("step 6 \n");
				if( j == 1) {
					free(a);
					free(c);
					free(o);
					return;
				}
				else s = s + 1;
				//printf("step 7 \n");
				o[j] = -1 * o[j];
				j = j - 1;
				//go to S4
			}else break;
		}
			//printf("step 5 \n");
			int temp = a[j-c[j]+s] ;
			a[j-c[j]+s] = a[j-q+s];
			a[j-q+s] = temp;
			c[j] = q;
			// goto S2
	}
	free(a);
	free(c);
        free(o);
        return;
}

// split string with a delimiter
char** splitString(char *a_str, char a_delim){

/*	printf("string to split %s",str);
	char *lch = str - 1; 
	char *pch = strchr(str, delim);
	char **result;
	int idx = 0;

	while (pch!=NULL){
		printf ("pch found at %d lch atc %d lenght is %d\n",pch-str,lch-str,pch-lch-1);
		int len = pch-lch-1;
		char *res = (char*)malloc(sizeof(char)*(len + 1));
		strncpy(res, lch + 1, len);
		*(res + len) = '\0';
		result = malloc(sizeof(char*) * count);
		*(result + idx++) = strdup(res);
		printf("%s\n", res);
		lch = pch;			
		pch = strchr(pch+1, delim);
	}
		printf ("end of the line from lch atc %d\n",lch-str);
		int len = (str + strlen(str) - 1) - (lch+1);
		char *res = (char*)malloc(sizeof(char)*(len + 1));
		strncpy(res, lch + 1, len);
		*(res + len) = '\0';
		result = malloc(sizeof(char*) * count);
		*(result + idx++) = strdup(res);
		printf("%s\n", res);
	
}*/
	char** result    = 0;
	size_t count     = 0;
	char* tmp        = a_str;
	char* last_comma = 0;
	char delim[2];
	delim[0] = a_delim;
	delim[1] = 0;

	// Count how many elements will be extracted. 
	while (*tmp)
	{
		if (a_delim == *tmp)
		{
			count++;
			last_comma = tmp;
		}
		tmp++;
	}
	// Add space for trailing token.
	count += last_comma < (a_str + strlen(a_str) - 1);
	// Add space for terminating null string so caller knows where the list of returned strings ends. 
	count++;
	result = malloc(sizeof(char*) * count);
	if (result)
	{
		size_t idx  = 0;
		char* token = strtok(a_str, delim);
		while (token)
		{
			assert(idx < count);
			*(result + idx++) = strdup(token);
			token = strtok(0, delim);
		}
		assert(idx == count - 1);
		*(result + idx) = 0;
	}
	return result;
}


//to read the input file
int readDistanceMatrix(char *path){
	FILE *fp;
	char buf[1000];
	fp =fopen(path,"r");
	if (!fp){
		printf("input file %s is not found\n", path);
		return 1;
	}
	fgets(buf,sizeof(buf), fp);
	numCities = atoi(buf);
	int count = 0;
	disMat = (int**) malloc(sizeof(int*) * (count+1));
			
	while (fgets(buf,sizeof(buf), fp)!=NULL) {
		    char** tokens = splitString(buf, ' ');	
		if (tokens){
			int *val = malloc(sizeof(int));
			int i = 0;			
			for (i = 0; *(tokens + i); i++){
			    val = realloc(val, sizeof(int) * (i+1));
			    val[i] = atoi(*(tokens + i));
			    free(*(tokens + i));
			}
			disMat = realloc(disMat, sizeof(int*) * (count+1));
			*(disMat + count++) = val;
   		}
		free(tokens);
        }
	fclose(fp);
	return 0;
}

// to find and display the min cost tour
int findOptimalPath(){
	int minCost= NULL;
	int *costs = malloc(sizeof(int));
	int i = 0;
	for (i = 0; *(permutations + i); i++){
		int *tour = *(permutations + i);
		//checking distance matrices
		int cost = *(*(disMat + *(tour+numCities-1)) + *tour); 
		int k = 0;		
		for (k =0; k < numCities - 1; k++){
			cost += *(*(disMat + *(tour + k)) + *(tour + k + 1)); 
		}
		if (minCost == NULL) minCost = cost;
		else if (*(costs + i) <= minCost) minCost = cost;

		printf(" tour %d :", i+1);
		int j = 0;
		for(j = 0; j < numCities; j++){
	        	printf(" %d ",*(tour + j)+1);				
		}
		printf(" cost %d \n", cost);
		costs = (int*)realloc(costs, sizeof(int) * (i+1));
		*(costs+i) = cost;
	}
		printf(" \n minCost : %d for tour Id(s)", minCost);
		int k = 0;
		for(k=0; *(costs + k); k++ )
			if(*(costs + k) == minCost)printf(" %d ",k+1);
		printf("\n");
	free(costs);
	return 0;
}

//to clean the 2D array variables created above
void * cleanMem(){
	int i = 0; 
	for (i = 0; *(permutations + i); i++){
		free(*(permutations + i));
	}
	free(permutations);
	for (i = 0; *(disMat + i); i++){
		free(*(disMat + i));
	}
	free(disMat);
}

int main(int argc, char** argv) {
	if (readDistanceMatrix(argv[1]) != 0){
		return 1;
	}
	findPermutations(numCities);
	int minTourId = findOptimalPath();
	cleanMem();
	return 0;
}

