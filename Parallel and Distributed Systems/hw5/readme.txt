1.To generate the reading for run the shell script exe.sh. 

2.It can be done manually after compilation without using the shell script as below.
	a. To Compile: gcc -fopenmp -lm -o main main.c
	b. To Run : bash -c "export  OMP_NUM_THREADS=<number of threads>; ./main <power of the size of the array>" 
	c. example: to compute the 2^8 array with 8 threads
	d. bash -c "export  OMP_NUM_THREADS=8; ./main 8 >> data.log"
	e. data will be written to data.log

3.the timing can be found in the data<order of array>.log

4. script.txt is the script file for the GNU. to execute it
	gnuplot -c script.txt <order of the array>
   it will take the data.log files as input and output out.png files

5. dataXsp.log's are the manually computed speedup file. to get the speedup plot run 
	gnuplot scriptsp.txt

6. doc.tex is the Latex that will take outX.png and speedup.png files as input. 
   to get the pdf file run
	pdflatex doc.tex

Note : the code is compiled and executed on tomis, but the gnuplot and Latex is writen in 
     Cygwin on my local system	