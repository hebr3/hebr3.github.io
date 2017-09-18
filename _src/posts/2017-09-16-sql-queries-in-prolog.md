    Title: SQL queries in Prolog
    Date: 2017-09-16T00:00:00
    Tags: SQL, Prolog, MIS522
    Authors: Henry Brooks

This post will be looking at solving [SQL](https://en.wikipedia.org/wiki/SQL) problems with [Prolog](https://en.wikipedia.org/wiki/Prolog).

I have been intrigued by Prolog for a while now because of its roots in first-order logic. I have been going through tutorials and examples looking for a way to leverage logic programming as a DSL in personal projects. I feel that Prolog could be used as a substitute for a more fully featured database languages in small projects.

<!-- more -->

I have found that most developers I have talked to have never really dug into Prolog as a language. More than one person has state that they consider Prolog to be a toy language only good for proving who your ancestor is. Personally I wish that my computer programming courses had touched on the language more.

Below you will find the code needed to create a simple database in both SQL and Prolog.

#### SQL

```SQL
CREATE TABLE CUSTOMER_t
(Customer_Id INT ,
Customer_Name VARCHAR(25) ,
Customer_Address VARCHAR(30) ,
Customer_City VARCHAR(20) , 
Customer_State VARCHAR(2) ,
Postal_Code VARCHAR(9) ,
CONSTRAINT CUSTOMER_PK PRIMARY KEY (Customer_Id));

CREATE TABLE ORDER_t
(Order_Id INT ,
Customer_Id INT ,
Order_Date DATE ,
CONSTRAINT ORDER_PK PRIMARY KEY (Order_Id),
CONSTRAINT ORDER_FK1 FOREIGN KEY (Customer_Id) REFERENCES CUSTOMER_t(Customer_Id));

CREATE TABLE PRODUCT_t
(Product_Id Int,
Product_Line_Id INT ,
Product_Description VARCHAR(50) ,
Product_Finish VARCHAR(20) ,
Standard_Price Decimal(6,2) ,
CONSTRAINT PRODUCT_PK PRIMARY KEY (Product_Id));

CREATE TABLE ORDER_LINE_t(
Order_Id INT,
Product_Id INT,
Ordered_Quantity INT,
CONSTRAINT Order_line_PK PRIMARY KEY ( Order_Id, Product_Id ) ,
CONSTRAINT Order_line_FK1 FOREIGN KEY ( Order_Id ) REFERENCES ORDER_t( Order_Id ) ,
CONSTRAINT Order_line_FK2 FOREIGN KEY ( Product_Id ) REFERENCES PRODUCT_t( Product_Id )
);


INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (2, 'Value Furniture', '15145 S.W. 17th St.', 'Plano', 'TX', '75094');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (3, 'Home Furnishings', '1900 Allard Ave.', 'Albany', 'NY', '12209');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (7, 'Period Furniture', '394 Rainbow Dr.', 'Seattle', 'WA', '97954');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (8, 'Calfornia Classics', '816 Peach Rd.', 'Santa Clara', 'CA', '96915');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (11, 'American Euro Lifestyles', '2424 Missouri Ave N.', 'Prospect Park', 'NJ', '07508');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (12, 'Battle Creek Furniture', '345 Capitol Ave. SW', 'Battle Creek', 'MI', '49015');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (13, 'Heritage Furnishings', '66789 College Ave.', 'Carlisle', 'PA', '17013');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (14, 'Kaneohe Homes', '112 Kiowai St.', 'Kaneohe', 'HI', '96744');
INSERT INTO CUSTOMER_t (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
VALUES (15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84403');


INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1001, '21/Oct/00', 1);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1002, '21/Oct/00', 8);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1003, '22/Oct/00', 15);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1004, '22/Oct/00', 5);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1005, '24/Oct/00', 3);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1006, '24/Oct/00', 2);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1007, '27/Oct/00', 11);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1008, '30/Oct/00', 12);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1009, '05/Nov/00', 4);
INSERT INTO ORDER_t (Order_Id, Order_Date, Customer_Id)
VALUES (1010, '05/Nov/00', 1);


INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (1, 'End Table', 'Cherry', 175, 1);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (2, 'Coffe Table', 'Natural Ash', 200, 2);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (3, 'Computer Desk', 'Natural Ash', 375, 2);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (4, 'Entertainment Center', 'Natural Maple', 650, 3);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (5, 'Writers Desk', 'Cherry', 325, 1);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (6, '8-Drawer Desk', 'White Ash', 750, 2);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (7, 'Dining Table', 'Natural Ash', 800, 2);
INSERT INTO PRODUCT_t (Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
VALUES (8, 'Computer Desk', 'Walnut', 250, 3);

INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1001, 1, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1001, 2, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1001, 4, 1);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1002, 3, 5);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1003, 3, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1004, 6, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1004, 8, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1005, 4, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1006, 4, 1);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1006, 5, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1006, 7, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1007, 1, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1007, 2, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1008, 3, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1008, 8, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1009, 4, 2);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1009, 7, 3);
INSERT INTO ORDER_LINE_t (Order_Id, Product_Id, Ordered_Quantity)
VALUES (1010, 8, 10);
```

#### Prolog

```Prolog
%customer(Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
customer(1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601').
customer(2, 'Value Furniture', '15145 S.W. 17th St.', 'Plano', 'TX', '75094').
customer(3, 'Home Furnishings', '1900 Allard Ave.', 'Albany', 'NY', '12209').
customer(4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008').
customer(5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206').
customer(6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514').
customer(7, 'Period Furniture', '394 Rainbow Dr.', 'Seattle', 'WA', '97954').
customer(8, 'Calfornia Classics', '816 Peach Rd.', 'Santa Clara', 'CA', '96915').
customer(9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620').
customer(10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646').
customer(11, 'American Euro Lifestyles', '2424 Missouri Ave N.', 'Prospect Park', 'NJ', '07508').
customer(12, 'Battle Creek Furniture', '345 Capitol Ave. SW', 'Battle Creek', 'MI', '49015').
customer(13, 'Heritage Furnishings', '66789 College Ave.', 'Carlisle', 'PA', '17013').
customer(14, 'Kaneohe Homes', '112 Kiowai St.', 'Kaneohe', 'HI', '96744').
customer(15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84403').

%order(Order_Id, Order_Date, Customer_Id)
order(1001, '21/Oct/00', 1).
order(1002, '21/Oct/00', 8).
order(1003, '22/Oct/00', 15).
order(1004, '22/Oct/00', 5).
order(1005, '24/Oct/00', 3).
order(1006, '24/Oct/00', 2).
order(1007, '27/Oct/00', 11).
order(1008, '30/Oct/00', 12).
order(1009, '05/Nov/00', 4).
order(1010, '05/Nov/00', 1).

%product(Product_Id, Product_Description, Product_Finish, Standard_Price, Product_Line_Id)
product(1, 'End Table', 'Cherry', 175, 1).
product(2, 'Coffe Table', 'Natural Ash', 200, 2).
product(3, 'Computer Desk', 'Natural Ash', 375, 2).
product(4, 'Entertainment Center', 'Natural Maple', 650, 3).
product(5, 'Writers Desk', 'Cherry', 325, 1).
product(6, '8-Drawer Desk', 'White Ash', 750, 2).
product(7, 'Dining Table', 'Natural Ash', 800, 2).
product(8, 'Computer Desk', 'Walnut', 250, 3).

%order_line(Order_Id, Product_Id, Ordered_Quantity)
order_line(1001, 1, 2).
order_line(1001, 2, 2).
order_line(1001, 4, 1).
order_line(1002, 3, 5).
order_line(1003, 3, 3).
order_line(1004, 6, 2).
order_line(1004, 8, 2).
order_line(1005, 4, 3).
order_line(1006, 4, 1).
order_line(1006, 5, 2).
order_line(1006, 7, 2).
order_line(1007, 1, 3).
order_line(1007, 2, 2).
order_line(1008, 3, 3).
order_line(1008, 8, 3).
order_line(1009, 4, 2).
order_line(1009, 7, 3).
order_line(1010, 8, 10).
```


List all customers
---

#### SQL

```SQL
SELECT *
FROM CUSTOMER_t;
```

```
1|Contemporary Casuals|1355 S Hines Blvd|Gainesville|FL|32601
2|Value Furniture|15145 S.W. 17th St.|Plano|TX|75094
3|Home Furnishings|1900 Allard Ave.|Albany|NY|12209
4|Eastern Furniture|1925 Beltline Rd.|Carteret|NJ|07008
5|Impressions|5585 Westcott Ct.|Sacramento|CA|94206
6|Furniture Gallery|325 Flatiron Dr.|Boulder|CO|80514
7|Period Furniture|394 Rainbow Dr.|Seattle|WA|97954
8|Calfornia Classics|816 Peach Rd.|Santa Clara|CA|96915
9|M and H Casual Furniture|3709 First Street|Clearwater|FL|34620
10|Seminole Interiors|2400 Rocky Point Dr.|Seminole|FL|34646
11|American Euro Lifestyles|2424 Missouri Ave N.|Prospect Park|NJ|07508
12|Battle Creek Furniture|345 Capitol Ave. SW|Battle Creek|MI|49015
13|Heritage Furnishings|66789 College Ave.|Carlisle|PA|17013
14|Kaneohe Homes|112 Kiowai St.|Kaneohe|HI|96744
15|Mountain Scenes|4132 Main Street|Ogden|UT|84403
```

#### Prolog

```Prolog
listing(customer).
```

```
customer(1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601').
customer(2, 'Value Furniture', '15145 S.W. 17th St.', 'Plano', 'TX', '75094').
customer(3, 'Home Furnishings', '1900 Allard Ave.', 'Albany', 'NY', '12209').
customer(4, 'Eastern Furniture', '1925 Beltline Rd.', 'Carteret', 'NJ', '07008').
customer(5, 'Impressions', '5585 Westcott Ct.', 'Sacramento', 'CA', '94206').
customer(6, 'Furniture Gallery', '325 Flatiron Dr.', 'Boulder', 'CO', '80514').
customer(7, 'Period Furniture', '394 Rainbow Dr.', 'Seattle', 'WA', '97954').
customer(8, 'Calfornia Classics', '816 Peach Rd.', 'Santa Clara', 'CA', '96915').
customer(9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620').
customer(10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646').
customer(11, 'American Euro Lifestyles', '2424 Missouri Ave N.', 'Prospect Park', 'NJ', '07508').
customer(12, 'Battle Creek Furniture', '345 Capitol Ave. SW', 'Battle Creek', 'MI', '49015').
customer(13, 'Heritage Furnishings', '66789 College Ave.', 'Carlisle', 'PA', '17013').
customer(14, 'Kaneohe Homes', '112 Kiowai St.', 'Kaneohe', 'HI', '96744').
customer(15, 'Mountain Scenes', '4132 Main Street', 'Ogden', 'UT', '84403').
```

List customers by name
---

#### SQL

```SQL
SELECT *
FROM CUSTOMER_t
ORDER BY Customer_Name;
```

```
11|American Euro Lifestyles|2424 Missouri Ave N.|Prospect Park|NJ|07508
12|Battle Creek Furniture|345 Capitol Ave. SW|Battle Creek|MI|49015
8|Calfornia Classics|816 Peach Rd.|Santa Clara|CA|96915
1|Contemporary Casuals|1355 S Hines Blvd|Gainesville|FL|32601
4|Eastern Furniture|1925 Beltline Rd.|Carteret|NJ|07008
6|Furniture Gallery|325 Flatiron Dr.|Boulder|CO|80514
13|Heritage Furnishings|66789 College Ave.|Carlisle|PA|17013
3|Home Furnishings|1900 Allard Ave.|Albany|NY|12209
5|Impressions|5585 Westcott Ct.|Sacramento|CA|94206
14|Kaneohe Homes|112 Kiowai St.|Kaneohe|HI|96744
9|M and H Casual Furniture|3709 First Street|Clearwater|FL|34620
15|Mountain Scenes|4132 Main Street|Ogden|UT|84403
7|Period Furniture|394 Rainbow Dr.|Seattle|WA|97954
10|Seminole Interiors|2400 Rocky Point Dr.|Seminole|FL|34646
2|Value Furniture|15145 S.W. 17th St.|Plano|TX|75094
```

List customers based on location
---

#### SQL

```SQL
SELECT *
FROM CUSTOMER_t
WHERE Customer_State = 'FL';
```

```
1|Contemporary Casuals|1355 S Hines Blvd|Gainesville|FL|32601
9|M and H Casual Furniture|3709 First Street|Clearwater|FL|34620
10|Seminole Interiors|2400 Rocky Point Dr.|Seminole|FL|34646
```

#### Prolog

```Prolog
customer_state([Id,Name,Addr,City,State,Zip],State):-
    customer(Id,Name,Addr,City,State,Zip).

bagof(L,customer_state(L,'FL'),List).
```

```
List = [[1, 'Contemporary Casuals', '1355 S Hines Blvd', 'Gainesville', 'FL', '32601'], [9, 'M and H Casual Furniture', '3709 First Street', 'Clearwater', 'FL', '34620'], [10, 'Seminole Interiors', '2400 Rocky Point Dr.', 'Seminole', 'FL', '34646']]
```

List customers who made purchases in October
---

#### SQL

```SQL
SELECT CUSTOMER_t.Customer_Name, ORDER_t.Order_Date
FROM CUSTOMER_t
INNER JOIN ORDER_t ON CUSTOMER_t.Customer_Id = ORDER_t.Customer_Id
WHERE ORDER_t.Order_Date LIKE '%Oct%';
```

```
Contemporary Casuals|21/Oct/00
Calfornia Classics|21/Oct/00
Mountain Scenes|22/Oct/00
Impressions|22/Oct/00
Home Furnishings|24/Oct/00
Value Furniture|24/Oct/00
American Euro Lifestyles|27/Oct/00
Battle Creek Furniture|30/Oct/00
```

#### Prolog

```Prolog
customer_month(CustomerName, Order_Date, Month):-
    customer(CustomerID,CustomerName,_,_,_,_),
    order(_, Order_Date, CustomerID),
    split_string(Order_Date,"/"," ", Date),
    nth1(2,Date,Month).

bagof([Name, Date],customer_month(Name, Date, "Oct"),L).
```

```
List = [['Contemporary Casuals', '21/Oct/00'], ['Value Furniture', '24/Oct/00'], ['Home Furnishings', '24/Oct/00'], ['Impressions', '22/Oct/00'], ['Calfornia Classics', '21/Oct/00'], ['American Euro Lifestyles', '27/Oct/00'], ['Battle Creek Furniture', '30/Oct/00'], ['Mountain Scenes', '22/Oct/00']]
```
