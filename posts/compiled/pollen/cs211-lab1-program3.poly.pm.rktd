#hash((doc . (body (h2 "Program 3") (p "Write a program with several functions that perform the following tasks:") (p "a. Read the following 10 integer numbers from the file data.txt into array A." (br) "     " "10 15 27 89 90 95 27 13 99 33" (br) " " "Call function ReadArray that reads numbers from the file data.txt into an array.") (p "b. Copy array A into array B in reverse order." (br) "Call function ReverseArray that copies an array into another array in reverse order") (p "c. Print the elements of Array A and B." (br) "Call function PrintArray that prints the elements of an array of any size") (p "d. Find the number of elements in array A that are >= 80 and <=100." (br) "Call function FindRange that finds and returns the number of elements in an array of any size that are within a certain range (min, max)") (p "e. Find the index of the elements in array A that are divisible by 5." (br) "Call function FindDiv that finds and returns the number of the elements in array that are divisible by 5") (p "f. Find average in array A." (br) "Call function ArrayAvg that finds and returns the average of elements in an array of any size") (p "g. Find the minimum number in array A." (br) "Call function ArrayMin that finds and returns the minimum number in an array of any size") (p "h. Ask the user to input a key. Then search for the key in array A and inform the user about the existence (true / false) of the key in array." (br) "Call function KeySearch that searches for a key in an array of any size and returns true/false as result") (p "NOTES:" (br) "- If a function is supposed to return a value, print that value in main not inside the function." (br) "- Any parameter that is not supposed to be changed inside a function must be declared as a constant parameter.") (div ((class "listing-filename")) 128196 " " "data.txt") (pre ((class "code")) "10 15 27 89 90 95 27 13 99 33") (div ((class "listing-filename")) 128196 " " "./a.out > output.txt") (pre ((class "code")) "10 15 27 89 90 95 27 13 99 33" "\n\n" "33 99 13 27 95 90 89 27 15 10" "\n\n" "There are 4 values in arrayA between 80 and 100." "\n\n" "There are elements divisible by 5 at positions 1, 2, 5, 6, 4" "\n\n" "The average of the array is 49.8" "\n\n" "The minimum element of the array is 10" "\n\n" "Enter an integer value to search for: True") (div ((class "listing-filename")) 128196 " " "Lab1_Program3.cpp") (pre ((class "code")) "#include <iostream>" "\n" "#include <fstream>" "\n" "#include <string>" "\n" "using namespace std;" "\n\n" "// Function prototypes *************************************************" "\n" "int fileSize();                        // aux" "\n" "void ReadArray(int [], int);            // a" "\n" "void ReverseArray(int [], int [], int); // b" "\n" "void PrintArray(int [], int);           // c" "\n" "int FindRange(int, int, int []);        // d" "\n" "int FindDiv(int, int []);               // e" "\n" "double ArrayAvg(int []);                // f" "\n" "int ArrayMin(int []);                   // g" "\n" "bool KeySearch(int, int []);            // h" "\n\n" "int main () {" "\n" "  " "// find length of the input" "\n" "  " "int SIZE = fileSize();" "\n\n" "  " "// initialize array A and B" "\n" "  " "int arrayA[SIZE];" "\n" "  " "int arrayB[SIZE];" "\n\n" "  " "// a. Read data from data2.txt to arrayA" "\n" "  " "ReadArray(arrayA, SIZE);" "\n\n" "  " "// b. Copy arrayA into arrayB in reverse order" "\n" "  " "ReverseArray(arrayA, arrayB, SIZE);" "\n\n" "  " "// c. Print arrayA and arrayB" "\n" "  " "PrintArray(arrayA, SIZE);" "\n" "  " "PrintArray(arrayB, SIZE);" "\n\n" "  " "// d. Find the number of elements in array between 80 and 100" "\n" "  " "cout << \"There are \"" "\n" "       " "<< FindRange(80, 100, arrayA)" "\n" "       " "<< \" values in arrayA between \"" "\n" "       " "<< 80" "\n" "       " "<< \" and \"" "\n" "       " "<< 100 << \".\"" "\n" "       " "<< endl <<endl;" "\n\n" "  " "// e. Find the number of elements divisible by 5" "\n" "  " "cout << \"There are elements divisible by 5 at positions \";" "\n" "  " "cout << FindDiv(5, arrayA)" "\n" "       " "<< endl << endl;" "\n\n" "  " "// f. Find the average of the array" "\n" "  " "cout << \"The average of the array is \"" "\n" "       " "<< ArrayAvg(arrayA)" "\n" "       " "<< endl << endl;" "\n\n" "  " "// g. Find the minimum element of the array" "\n" "  " "cout << \"The minimum element of the array is \"" "\n" "       " "<< ArrayMin(arrayA)" "\n" "       " "<< endl << endl;" "\n\n" "  " "// h. Search for an element in an array" "\n" "  " "int num;" "\n" "  " "cout << \"Enter an integer value to search for: \";" "\n" "  " "cin >> num;" "\n" "  " "cout << (KeySearch(num, arrayA) ? \"True\" : \"False\")" "\n" "       " "<< endl << endl;" "\n\n" "  " "return 0;" "\n" "}" "\n\n" "//Function definitions *************************************************" "\n\n" "int fileSize() {" "\n" "  " "int count = 0;" "\n" "  " "int temp = 0;" "\n" "  " "ifstream inputFile;" "\n" "  " "inputFile.open(\"data2.txt\");" "\n" "  " "while (inputFile >> temp)" "\n" "    " "count++;" "\n" "  " "inputFile.close();" "\n" "  " "return count;" "\n" "}" "\n\n" "void ReadArray(int arr[], int size) {" "\n" "  " "// initialize ifstream to read file" "\n" "  " "ifstream inputFile;" "\n" "  " "inputFile.open(\"data2.txt\");" "\n\n" "  " "if (inputFile.is_open()) { // Only do these if file is open" "\n" "    " "// Pull data off data2.txt and place in arr" "\n" "    " "for (int i = 0; i < size; i++) {" "\n" "      " "inputFile >> arr[i];" "\n" "    " "}" "\n" "  " "}" "\n\n" "  " "// Close the file" "\n" "  " "inputFile.close();" "\n" "}" "\n\n" "void ReverseArray(int arrayA[], int arrayB[], int size) {" "\n" "  " "for(int i = 0; i < size; i++) {" "\n" "    " "arrayB[i] = arrayA[9 - i];" "\n" "  " "}" "\n" "}" "\n\n" "void PrintArray(int arr[], int size) {" "\n" "  " "for (int i = 0; i < size; i++) {" "\n" "    " "cout << arr[i] << \" \";" "\n" "  " "}" "\n" "  " "cout << endl << endl;" "\n" "}" "\n\n" "int FindRange(int first, int second, int arr[10]) {" "\n" "  " "int count = 0;" "\n" "  " "for(int i = 0; i < 10; i++) {" "\n" "    " "if(arr[i] > first) {" "\n" "      " "if(arr[i] < second) {" "\n" "        " "count += 1;" "\n" "      " "}" "\n" "    " "}" "\n" "  " "}" "\n" "  " "return count;" "\n" "}" "\n\n" "int FindDiv(int num, int arr[10]) {" "\n" "  " "int count = 0;" "\n" "  " "for (int i = 0; i < 10; i++) {" "\n" "    " "if (arr[i] % num == 0) {" "\n" "      " "cout << i+1 << \", \";" "\n" "      " "count += 1;" "\n" "    " "}" "\n" "  " "}" "\n" "  " "return count;" "\n" "}" "\n\n" "double ArrayAvg(int arr[10]) {" "\n" "  " "int sum = 0;" "\n" "  " "for(int i = 0; i < 10; i++) {" "\n" "    " "sum += arr[i];" "\n" "  " "}" "\n" "  " "return sum / 10.0;" "\n" "}" "\n\n" "int ArrayMin(int arr[10]) {" "\n" "  " "int min = arr[0];" "\n" "  " "for(int i = 1; i < 10; i++) {" "\n" "    " "if(arr[i] < min) {" "\n" "      " "min = arr[i];" "\n" "    " "}" "\n" "  " "}" "\n" "  " "return min;" "\n" "}" "\n\n" "bool KeySearch(int num, int arr[10]) {" "\n" "  " "for(int i = 0; i < 10; i++) {" "\n" "    " "if(arr[i] == num) {" "\n" "      " "return true;" "\n" "    " "}" "\n" "  " "}" "\n" "  " "return false;" "\n" "}") (div ((class "listing-filename")) 128196 " " "Lab1_Program2.cpp") (pre ((class "code")) "#lang racket" "\n"))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\cs211-lab1-program3.poly.pm") (published . "2017-01-30") (title . "CS211-Lab1-Program3 in Racket") (topics . "CS211,Racket,C++"))))