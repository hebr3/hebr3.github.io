#lang pollen

◊(define-meta title "CS211-Lab1-Program2 in Racket")
◊(define-meta published "2017-01-27")
◊(define-meta topics "CS211,Racket,C++")

◊section{Program 2}

Write a program that reads test scores of students in a programming class from an input file, data.txt, and calculates the minimum, maximum, average test score for each student as well as the overall average score for the class. Each row of the file contains student name (no spaces), and 3 scores for test 1, test 2, and test 3, respectively.

Your main program should:
- open the file and check for successful open,
- then start reading one line at a time until EOF. For each line read, pass the grades for the three tests to a function called ProcessARow that calculates the minimum, maximum and average of the three grades. The results (minimum, maximum, and average) should be returned to the main program and the main program prints them on the screen in a table format.
NOTE: minimum, maximum, average need to be sent by reference
- Call the function, ProcessOverall, that calculates the overall average of all grades.
NOTE: parameters must be sent by value

◊blockcode[#:filename "data.txt"]{
Bob     78   92   88
Sue     89   94   78
Fred   100   80   92
George  90   90   85
Mary    95   70   99
Jane   100   92   87}

◊blockcode[#:filename "output"]{
Name           Average Score
------------------------------
Bob                86.00
Sue                87.00
Fred               90.66
George             90.00
Mary               88.33
Jane               93.00
------------------------------
Overall Average:   89.16}

◊filebox-highlight["Lab1_Program1.cpp" 'c++]{
#include <iostream>
#include <fstream>
#include <iomanip>
#include <string>
#include <cmath>
using namespace std;

void ProcessARow(int, int, int, double&, int&, int&);
double ProcessOverall(double);

int main () {
  // initialize file
  ifstream inputFile;
  inputFile.open("data.txt");
    
  // init variables
  int first, second, third, minimum, maximum;
  double average,
         total = 0;
  string name;
  
  if (inputFile.is_open()) {
    cout << endl;
    cout << "Name                Avg    Min    Max" << endl;
    cout << "-------------------------------------" << endl;
	  
    while (inputFile.good()) {		  
      // Pull info off file
      inputFile >> name >> first >> second >> third;
		  
      // Send values to ProcessARow
      ProcessARow(first, second, third, average, minimum, maximum);
		  
      // Add average to total
      total += average;
		  		  
      // Output average for student
      cout << setw(18) << left << name
           << setprecision(2) << fixed << showpoint << right 
           << average << "     " 
           << minimum << "    "
           << setw(3) << right << maximum << endl;
		  
    }
	  
    // Close the file
    inputFile.close();
	  
    cout << "-------------------------------------" << endl;
    cout << "Overall Average:  " << ProcessOverall(total) << endl << endl;
	  
  }
  else {
    cout << "Unable to open file";
  }

  return 0;
}

void ProcessARow(int first, int second, int third, double& avg, int& minimum, int& maximum) {
  int sum;
  sum = first + second + third;
  avg = sum / 3.0;
  maximum = max(max(first, second), third);
  minimum = min(min(first, second), third);
}

double ProcessOverall(double avgs) {
  return avgs / 6.0;
}
}

◊filebox-highlight["Lab1_Program2.cpp" 'racket]{
#lang racket

}
