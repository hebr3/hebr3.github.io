#hash((doc . (body (p "I thought I would try a different approach to completing the assignment this week. Usually I modify the example problems and templates to fit the needs of the program.") (p "This week I thought figured I would try giving a testing based methodology a try. Specifically I wanted to incrementally build the program up by compiling and testing as I built it from scratch.") (h2 "Lab 7") (p "The purpose of this lab is to practice working with constants, static attributes, and friend functions.") (p "In this lab, you will design a " (em "Student") " class which has the following private attributes:") (ul "string name;") (ul "const long studentID;") (h2 "Version 1") (p "I start with a constructor, setter, and getter for the required class. I test to make sure that all three are being called properly in main.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "main.cpp") (div ((class "highlight")) (pre (code "#include <iostream>\nusing namespace std;\n\nint main() {\n    Student student1;\n\n    cout << student1.getName() << endl;\n\n    student1.setName(\"steve\");\n\n    cout << student1.getName() << endl;\n\n    return 0;\n}")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.h") (div ((class "highlight")) (pre (code "#ifndef STDUENT_H\n#define STUDENT_H\n#include <string>\nusing namespace std;\n\nclast Student {\n    private:\n        string name;\n    public:\n        Student();\n        string getName() const;\n        void setName();\n };\n#endif")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.cpp") (div ((class "highlight")) (pre (code "#include \"Student.h\"\n#include <string>\nusing namespace std;\n\nStudent::Student() {\n    name = \"Unknown\";\n}\n\nstring Student::getName() const {\n    return name;\n}\n\nvoid Student::setName(string n) {\n    name = n;\n}")))) (h2 "Version 2") (p "Since the basic skeleton of the program was running I expanded the class to include studentID, major, classification, units, and tuition. My main.cpp is also expanded to test all of the variables added to the class.") (p "Note: I had some issues with this step. You need to remember to declare constant member values outside of the {} brackets of the constructor.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "main.cpp") (div ((class "highlight")) (pre (code "#include <iostream>\nusing namespace std;\n\nint main() {\n    Student student1;\n\n    cout << student1.getName() << \" \"\n         << student1.getID() << \" \"\n         << student1.getMajor() << \" \"\n         << student1.getClassification() << \" \"\n         << student1.getUnits() << endl;\n\n    student1.setName(\"steve\");\n    student1.setMajor(\"MATH\");\n    student1.setClassification(\"graduate\");\n    student1.setUnits(8);\n    student1.setTuition(1000.50);\n\n    cout << student1.getName() << \" \"\n         << student1.getID() << \" \"\n         << student1.getMajor() << \" \"\n         << student1.getClassification() << \" \"\n         << student1.getUnits() << endl;\n\n    Student student2 = Student(\"Julia Robertson\", \"MATH\", \"undergraduate\", 15);\n\n    cout << student2.getName() << \" \"\n         << student2.getID() << \" \"\n         << student2.getMajor() << \" \"\n         << student2.getClassification() << \" \"\n         << student2.getUnits() << endl;\n\n    return 0;\n}")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.h") (div ((class "highlight")) (pre (code "#ifndef STDUENT_H\n#define STUDENT_H\n#include <string>\nusing namespace std;\n\nclast Student {\n    private:\n        string name;\n        const long studentID;\n        string major;\n        string classification;\n        int units;\n        float tuition;\n    public:\n        Student();\n        Student(string, string, string, int);\n\n        string getName() const;\n        long getId() const;\n        string getMajor() const;\n        string getClassification() const;\n        int getUnits() const;\n        float getTuition() const;\n\n        void setName();\n        void setMajor(string);\n        void setClassification(string);\n        void setUnits(int);\n        void setTuition(float);\n };\n#endif")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.cpp") (div ((class "highlight")) (pre (code "#include \"Student.h\"\n#include <string>\nusing namespace std;\n\n// Constructor functions\nStudent::Student() {\n    name = \"Unknown\";\n    major = \"CS\";\n    classification = \"undergraduate\";\n    units = 12;\n    tuition = 0;\n}\nStudent::Student(string theName, string theMajor, string theClassification, int theUnits) : studentID(0) {\n        name = theName;\n        major = theMajor;\n        classification = theClassification;\n        units = theUnits;\n        tuition = 0;\n}\n\n// Getter functions\nstring Student::getName() const {\n        return name;\n}\nlong Student::getID() const {\n        return studentID;\n}\nstring Student::getMajor() const {\n        return major;\n}\nstring Student::getClassification() const {\n        return classification;\n}\nint Student::getUnits() const {\n        return units;\n}\nfloat Student::getTuition() const {\n        return tuition;\n}\n\n// Setter functions\nvoid Student::setName(string n) {\n        name = n;\n}\nvoid Student::setMajor(string m) {\n        major = m;\n}\nvoid Student::setClassification(string c) {\n        classification = c;\n}\nvoid Student::setUnits(int u) {\n        units = u;\n}\nvoid Student::setTuition(float t) {\n        tuition = t;\n}")))) (h2 "Version 3") (p "I now add the totalNumofStudents and nextStudentID values to the class. I also add the destructor to the class sense the value it deals with has been added.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "main.cpp") (div ((class "highlight")) (pre (code "#include <iostream>\nusing namespace std;\n\nint main() {\n    Student student1;\n\n    cout << student1.getName() << \" \"\n         << student1.getID() << \" \"\n         << student1.getMajor() << \" \"\n         << student1.getClassification() << \" \"\n         << student1.getUnits() << \" \"\n         << student1.getTotalNumofStudents() << \" \"\n         << student1.getNextStudentID() << endl;\n\n    student1.setName(\"steve\");\n    student1.setMajor(\"MATH\");\n    student1.setClassification(\"graduate\");\n    student1.setUnits(8);\n    student1.setTuition(1000.50);\n\n    cout << student1.getName() << \" \"\n         << student1.getID() << \" \"\n         << student1.getMajor() << \" \"\n         << student1.getClassification() << \" \"\n         << student1.getUnits() << \" \"\n         << student1.getTotalNumofStudents() << \" \"\n         << student1.getNextStudentID() << endl;\n\n    Student student2 = Student(\"Julia Robertson\", \"MATH\", \"undergraduate\", 15);\n\n    cout << student2.getName() << \" \"\n         << student2.getID() << \" \"\n         << student2.getMajor() << \" \"\n         << student2.getClassification() << \" \"\n         << student2.getUnits() << \" \"\n         << student1.getTotalNumofStudents() << \" \"\n         << student1.getNextStudentID() << endl;\n\n    student1.~Student();\n\n    cout << student2.getName() << \" \"\n         << student2.getID() << \" \"\n         << student2.getMajor() << \" \"\n         << student2.getClassification() << \" \"\n         << student2.getUnits() << \" \"\n         << student1.getTotalNumofStudents() << \" \"\n         << student1.getNextStudentID() << endl;\n\n    return 0;\n}")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.h") (div ((class "highlight")) (pre (code "#ifndef STDUENT_H\n#define STUDENT_H\n#include <string>\nusing namespace std;\n\nclast Student {\n    static int totalNumofStudents;\n    static long nextStudentID;\n\n    private:\n        string name;\n        const long studentID;\n        string major;\n        string classification;\n        int units;\n        float tuition;\n    public:\n        Student();\n        Student(string, string, string, int);\n        ~Student();\n\n        string getName() const;\n        long getId() const;\n        string getMajor() const;\n        string getClassification() const;\n        int getUnits() const;\n        float getTuition() const;\n        int getTotalNumofStudents() const;\n        long getNextStudentID() const;\n\n        void setName();\n        void setMajor(string);\n        void setClassification(string);\n        void setUnits(int);\n        void setTuition(float);\n};\n#endif")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.cpp") (div ((class "highlight")) (pre (code "#include \"Student.h\"\n#include <string>\nusing namespace std;\n\nint Student::totalNumofStudents = 0;\nlong Student::nextStudentID = 10000;\n\n// Constructor functions\nStudent::Student() : studentID(nextStudentID) {\n    name = \"Unknown\";\n    major = \"CS\";\n    classification = \"undergraduate\";\n    units = 12;\n    tuition = 0;\n}\nStudent::Student(string theName, string theMajor, string theClassification, int theUnits) : studentID(nextStudentID) {\n        name = theName;\n        major = theMajor;\n        classification = theClassification;\n        units = theUnits;\n        tuition = 0;\n}\nStudent::~Student() {\n    totalNumofStudents--;\n}\n\n// Getter functions\nstring Student::getName() const {\n        return name;\n}\nlong Student::getID() const {\n        return studentID;\n}\nstring Student::getMajor() const {\n        return major;\n}\nstring Student::getClassification() const {\n        return classification;\n}\nint Student::getUnits() const {\n        return units;\n}\nfloat Student::getTuition() const {\n        return tuition;\n}\nint Student::getTotalNumofStudents() const {\n    return totalNumofStudents;\n}\nlong Student::getNextStudentID() const {\n    return nextStudentID;\n}\n\n// Setter functions\nvoid Student::setName(string n) {\n        name = n;\n}\nvoid Student::setMajor(string m) {\n        major = m;\n}\nvoid Student::setClassification(string c) {\n        classification = c;\n}\nvoid Student::setUnits(int u) {\n        units = u;\n}\nvoid Student::setTuition(float t) {\n        tuition = t;\n}")))) (h2 "Version 4") (p "Next I add the printStudent, setData, and setTuition functions to finish off the assignment.  I also clean up the files to align with the specs given in the written assignment.") (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "main.cpp") (div ((class "highlight")) (pre (code "#include <iostream>\nusing namespace std;\n\nvoid setTuition(Student &stu) {\n    if (stu.classification == \"graduate\")\n        stu.tuition = stu.units * 1000;\n    else\n        stu.tuition = stu.units * 700;\n}\n\nint main() {\n    Student student1;\n    student1.printStudent();\n\n    Student student2 = Student(\"unknown\", \"PHYS\", \"graduate\", 0);\n    student2.setData(); // \"Julia Robertson\", \"MATH\", \"undergraduate\", 15\n\n    setTuition(student2);\n    student2.printStudent();\n\n    return 0;\n}")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.h") (div ((class "highlight")) (pre (code "#ifndef STDUENT_H\n#define STUDENT_H\n#include <string>\nusing namespace std;\n\nclast Student {\n    static int totalNumofStudents;\n    static long nextStudentID;\n\n    friend void setTuition(Students&);\n\n    private:\n        string name;\n        const long studentID;\n        string major;\n        string classification;\n        int units;\n        float tuition;\n    public:\n        Student();\n        Student(string, string, string, int);\n        ~Student();\n\n        string getName() const;\n        long getId() const;\n        string getMajor() const;\n        string getClassification() const;\n        int getUnits() const;\n        float getTuition() const;\n        int getTotalNumofStudents() const;\n        long getNextStudentID() const;\n\n        void setName();\n        void setMajor(string);\n        void setClassification(string);\n        void setUnits(int);\n        void setTuition(float);\n};\n#endif")))) (div ((class "filebox")) (div ((class "filename") (decode "exclude")) "Student.cpp") (div ((class "highlight")) (pre (code "#include \"Student.h\"\n#include <string>\nusing namespace std;\n\nint Student::totalNumofStudents = 0;\nlong Student::nextStudentID = 10000;\n\n// Constructor functions\nStudent::Student() {\n    name = \"Unknown\";\n    major = \"CS\";\n    classification = \"undergraduate\";\n    units = 12;\n    tuition = 0;\n}\nStudent::Student(string theName, string theMajor, string theClassification, int theUnits) : studentID(0) {\n        name = theName;\n        major = theMajor;\n        classification = theClassification;\n        units = theUnits;\n        tuition = 0;\n}\nStudent::~Student() {\n    totalNumofStudents--;\n}\n\n// Getter functions\nstring Student::getName() const {\n        return name;\n}\nlong Student::getID() const {\n        return studentID;\n}\nstring Student::getMajor() const {\n        return major;\n}\nstring Student::getClassification() const {\n        return classification;\n}\nint Student::getUnits() const {\n        return units;\n}\nfloat Student::getTuition() const {\n        return tuition;\n}\nint Student::getTotalNumofStudents() const {\n    return totalNumofStudents;\n}\nlong Student::getNextStudentID() const {\n    return nextStudentID;\n}\n\nvoid Student:printStudent() const {\n    cout << \"Student name:   \" << name << endl\n         << \"Student id:     \" << studentID << endl\n         << \"Student major:  \" << major << endl\n         << \"Student class:  \" << classification << endl\n         << \"Student units:  \" << units << endl\n         << \"Tuition:        \" << tuition << endl;\n}\n\n// Setter functions\nvoid Student::setName(string n) {\n        name = n;\n}\nvoid Student::setMajor(string m) {\n        major = m;\n}\nvoid Student::setClassification(string c) {\n        classification = c;\n}\nvoid Student::setUnits(int u) {\n        units = u;\n}\nvoid Student::setTuition(float t) {\n        tuition = t;\n}\n\nvoid Student::setData() {\n    string n, m, c; \t\t// Name, Major, and Classification\n    int u;\t\t\t// Units\n    cout << \"Please enter the students name: \";\n    getline(cin, n);\n    name = n;\n    cout << \"Please enter the students major: \";\n    cin >> m;\n    major = m;\n    cout << \"Please enter the students classification: \";\n    cin >> c;\n    classification = c;\n    cout << \"Please enter the students units: \";\n    cin >> u;\n    units = u;\n}")))))) (metas . #hasheq((here-path . "C:\\GitHub\\hebr3.github.io\\posts\\cs211-lab7.poly.pm") (published . "2017-03-05") (title . "CS211-Lab7") (topics . "CS211,C++"))))