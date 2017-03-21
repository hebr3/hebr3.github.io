#lang pollen

◊(define-meta title "CS211-Lab2 in Racket")
◊(define-meta published "2017-02-03")
◊(define-meta topics "CS211,Racket,C++")

The purpose of this lab is to practice working with vectors.

Write a program that reads an unknown number of integers from a data file called "data.txt" into a vector of integers named V. V is initially empty and grows as the user reads data from file.

Once done copying data into vector V, you need to print the contents of V and perform some other tasks on the vector as described below.

Your program should do the following:  

Create an empty vector of integers V. 
Read the integers from data.txt into V.
Ask the user to input a key. Then search for the key in vector V and inform the user about the existence (true / false) of the key in V.
Print the contents of V.

◊blockcode[#:filename "data.txt"]{
5 6 12 87 100 28 35 66 77 29}

◊blockcode[#:filename "./a.out > output.txt input=>12"]{

Please enter a key to search for in data3.txt: 5
6
12 <--
87
100
28
35
66
77
29

The key was found

}

◊blockcode[#:filename "Lab1_Program3.cpp"]{
#include <vector>
#include <iostream>
#include <fstream>
using namespace std;

int main()
{
  // Initialized empty vector
  vector<int> V;
	
  // Initialized holding variable
  int holding;
	
  // Initialized inputFile
  ifstream inputFile;
  inputFile.open("data.txt");
	
  // Load first element of inputFile into holding
  inputFile >> holding;
  
  // While inputFile is sending results
  while (inputFile) {
    V.push_back(holding);
    inputFile >> holding;
  }
	
  // Close inputfile
  inputFile.close();
	
	
  cout << endl 
       <<"Please enter a key to search for in data3.txt: ";
	
  // Initialize key and search flag
  int key;
  bool found = false;
	
  // Get user input
  cin >> key;
	
  // Check all values in vector
  for (int val : V) {
    cout << val;
    if (val == key) {
      cout << " <--" << endl;
      found = true;
    } else {
      cout << endl;
    }
  }
	
  cout << endl;
		
  // If the found flag is true output positive result
  if (found) {
    cout << "The key was found" << endl << endl;
  } else {
    cout << "The key was not found" << endl;
  }
	
}
}

◊blockcode[#:filename "Lab1_Program2.cpp"]{
#lang racket

}
