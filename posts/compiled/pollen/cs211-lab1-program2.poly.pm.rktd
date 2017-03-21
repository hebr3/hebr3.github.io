#hash((doc . (body (h2 "Program 2") (p "Write a program that reads test scores of students in a programming class from an input file, data.txt, and calculates the minimum, maximum, average test score for each student as well as the overall average score for the class. Each row of the file contains student name (no spaces), and 3 scores for test 1, test 2, and test 3, respectively.") (p "Your main program should:" (br) "- open the file and check for successful open," (br) "- then start reading one line at a time until EOF. For each line read, pass the grades for the three tests to a function called ProcessARow that calculates the minimum, maximum and average of the three grades. The results (minimum, maximum, and average) should be returned to the main program and the main program prints them on the screen in a table format." (br) "NOTE: minimum, maximum, average need to be sent by reference" (br) "- Call the function, ProcessOverall, that calculates the overall average of all grades." (br) "NOTE: parameters must be sent by value") (div ((class "listing-filename")) 128196 " " "data.txt") (pre ((class "code")) "Bob     78   92   88" "\n" "Sue     89   94   78" "\n" "Fred   100   80   92" "\n" "George  90   90   85" "\n" "Mary    95   70   99" "\n" "Jane   100   92   87") (div ((class "listing-filename")) 128196 " " "output") (pre ((class "code")) "Name           Average Score" "\n" "------------------------------" "\n" "Bob                86.00" "\n" "Sue                87.00" "\n" "Fred               90.66" "\n" "George             90.00" "\n" "Mary               88.33" "\n" "Jane               93.00" "\n" "------------------------------" "\n" "Overall Average:   89.16") (div ((class "listing-filename")) 128196 " " "Lab1_Program1.cpp") (pre ((class "code")) "#include <iostream>" "\n" "#include <fstream>" "\n" "#include <iomanip>" "\n" "#include <string>" "\n" "#include <cmath>" "\n" "using namespace std;" "\n\n" "void ProcessARow(int, int, int, double&, int&, int&);" "\n" "double ProcessOverall(double);" "\n\n" "int main () {" "\n" "  " "// initialize file" "\n" "  " "ifstream inputFile;" "\n" "  " "inputFile.open(\"data.txt\");" "\n\n" "  " "// init variables" "\n" "  " "int first, second, third, minimum, maximum;" "\n" "  " "double average," "\n" "         " "total = 0;" "\n" "  " "string name;" "\n\n" "  " "if (inputFile.is_open()) {" "\n" "    " "cout << endl;" "\n" "    " "cout << \"Name                Avg    Min    Max\" << endl;" "\n" "    " "cout << \"-------------------------------------\" << endl;" "\n\n" "    " "while (inputFile.good()) {" "\n" "      " "// Pull info off file" "\n" "      " "inputFile >> name >> first >> second >> third;" "\n\n" "      " "// Send values to ProcessARow" "\n" "      " "ProcessARow(first, second, third, average, minimum, maximum);" "\n\n" "      " "// Add average to total" "\n" "      " "total += average;" "\n\n" "      " "// Output average for student" "\n" "      " "cout << setw(18) << left << name" "\n" "           " "<< setprecision(2) << fixed << showpoint << right" "\n" "           " "<< average << \"     \"" "\n" "           " "<< minimum << \"    \"" "\n" "           " "<< setw(3) << right << maximum << endl;" "\n\n" "    " "}" "\n\n" "    " "// Close the file" "\n" "    " "inputFile.close();" "\n\n" "    " "cout << \"-------------------------------------\" << endl;" "\n" "    " "cout << \"Overall Average:  \" << ProcessOverall(total) << endl << endl;" "\n\n" "  " "}" "\n" "  " "else {" "\n" "    " "cout << \"Unable to open file\";" "\n" "  " "}" "\n\n" "  " "return 0;" "\n" "}" "\n\n" "void ProcessARow(int first, int second, int third, double& avg, int& minimum, int& maximum) {" "\n" "  " "int sum;" "\n" "  " "sum = first + second + third;" "\n" "  " "avg = sum / 3.0;" "\n" "  " "maximum = max(max(first, second), third);" "\n" "  " "minimum = min(min(first, second), third);" "\n" "}" "\n\n" "double ProcessOverall(double avgs) {" "\n" "  " "return avgs / 6.0;" "\n" "}") (div ((class "listing-filename")) 128196 " " "Lab1_Program2.cpp") (pre ((class "code")) "#lang racket" "\n"))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\cs211-lab1-program2.poly.pm") (published . "2017-01-27") (title . "CS211-Lab1-Program2 in Racket") (topics . "CS211,Racket,C++"))))