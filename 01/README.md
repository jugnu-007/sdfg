<div align="center"><h1>Assignment 1</h1></div>


Create the following tables using the schema given below and insert given data set accordingly.

---

<div align="center"><h3>Table Name: client_master</h3></div>


**Description- Used to store client information**

|**Column No**|**Column Name**|**Data Type**|**Size**|**Attributes**|
| - | - | - | - | - |
|1|Client\_no|Varchar2|6|Primary key, first letter must start with ‘C’|
|2|Name|Varchar2|30|Not NULL|
|3|Address1|Varchar2|30||
|4|Address2|Varchar2|30||
|5|City|Varchar2|15||
|6|State|Varchar2|15||
|7|Pincode|Number|6||
|8|Balance\_due|Number|10,2||


**Data of client\_master table**

|**Col-1**|**Col-2**|**Col-3**|**Col-4**|**Col-5**|**Col-6**|**Col-7**|**Col-**|
| - | - | - | - | - | - | - | - |
|C001|Ivan Bayross|P-76|Worli|Bombay|Maharastra|400054|150 00|
|C002|VandanaSatiwal|128|Adams Street|Madras|TamilNadu|780001|0|
|C003|PramadaJaguste|157|Gopalpur|Kolkata|West Bengal|700058|500 0|
|C004|BasuNavindgi|A/12|Nariman|Bombay|Maharastra|400056|0|
|C005|Ravi Sreedharan|B/34|Rajnagar|Delhi|Delhi|100001|200 0|
|C006|Rukmini|Q-12|Bandra|Bombay|Maharastra|400050|0|

---

<div align="center"><h3>Table Name: product_master</h3></div>


**Description- Used to store product information**

|**Column No**|**Column Name**|**Data Type**|**Size**|**Attributes**|
| - | - | - | - | - |
|1|Product\_no|Varchar2|6|Primary key, First letter must start with ‘P’|
|2|Description|Varchar2|40|Not null|
|3|Profit\_percent|Number|4,2|Not null|
|4|Unit\_measure|Varchar2|10|Not null|
|5|Qty\_on\_hand|Number|8|Not null|
|6|Reorder\_level|Number|8|Not null|
|7|Sell\_price|Number|8,2|Not null, cannot be 0|
|8|Cost\_price|Number|8,2|Not null, cannot be 0|




**Data of product\_master table**

|**Col-1**|**Col-2**|**Col-3**|**Col-4**|**Col-5**|**Col-6**|**Col-7**|**Col-8**|
| - | - | - | - | - | - | - | - |
|P00001|1\.44 Floppies|5|Piece|100|20|525|500|
|P03453|Monitors|6|Piece|10|3|12000|11280|
|P06734|Mouse|5|Piece|20|5|1050|1000|
|P07865|1\.22 Floppies|5|Piece|100|20|525|500|
|P07868|Keyboard|2|Piece|10|3|3150|3050|
|P07885|CD Drive|2\.5|Piece|10|3|5250|5100|
|P07965|540 HDD|4|Piece|10|3|8400|8000|
|P07975|1\.44 Drive|5|Piece|10|3|1050|900|
|P08865|1\.22 Drive|5|Piece|2|3|1025|850|


---

<div align="center"><h3>Table Name: salesman_master</h3></div>

**Description- Used to store salesman working for company**

|**Column No**|**Column Name**|**Data Type**|**Size**|**Attributes**|
| - | - | - | - | - |
|1|Salesman\_no|Varchar2|6|Primary key,first letter must start with ‘S’|
|2|Salesman \_name|Varchar2|30|Not null|
|3|Address1|Varchar2|30|Not null|
|4|Address2|Varchar2|30||
|5|City|Varchar2|20||
|6|Pincode|Number|8||
|7|State|Varchar2|20||
|8|Sal\_amt|Number|8, 2|Not null, cannot be 0|

**Data of salesman\_master table**

|**Col-1**|**Col-2**|**Col-3**|**Col-4**|**Col-5**|**Col-6**|**Col-7**|**Col-8**|
| - | - | - | - | - | - | - | - |
|S001|Kiran|A/14|Worli|Bombay|400002|Maharastra|3000|
|S002|Manish|65|Nariman|Bombay|400001|Maharastra|3000|
|S003|Ravi|P-7|Bandra|Bombay|400032|Maharastra|3000|
|S004|Asish|A/5|Juhu|Bombay|400044|Maharastra|3000|


<div align="center"><h3>Table Name: sales_order</h3></div>



**Description- Used to store client’s orders**

|**Column No**|**Column Name**|**Data Type**|**Size**|**Attributes**|
| - | - | - | - | - |
|1|Order\_no|Varchar2|6|Primary key, first letter must start with ‘O’|
|2|Order\_date|Date|||
|3|Client\_no|Varchar2|6|Foreign key references Client\_master table|
|4|Salesman\_no|Varchar2|6|Foreign key references salesman \_master table|
|5|Delivery\_type|Char|1|Delivery part(P),full(F) Default ‘F’|
|6|Bill\_y\_n|Char|1||
|7|Delivery\_date|Date||Cannot be less than Order\_date|
|8|Order\_status|Varchar2|10|Values(‘InProcess’,’ Fullfilled’, ‘BackOrder’, ‘Cancelled’)|


**Data of sales\_order table**

|**Col-1**|**Col-2**|**Col-3**|**Col-4**|**Col-5**|**Col 6**|**Col-7**|**Col-8**|
| - | - | - | - | - | :-: | - | - |
|O19001|12-Jan-96|C001|S001|F|N|20-Jan-96|InProcess|
|O19002|25-Jan-96|C002|S002|P|N|27-Jan-96|BackOrder|
|O46865|18-Feb-96|C003|S003|F|Y|20-Feb-96|Fullfilled|
|O19003|03-Apr-96|C001|S001|F|Y|07-Apr-96|Fullfilled|
|O46866|20-May-96|C004|S002|P|N|22-May-96|Cancelled|
|O19008|24-May-96|C005|S004|F|N|26-May-96|InProcess|

---


<div align="center"><h3>Table Name: sales_order_details</h3></div>



**Description- Used to store client’s orders with details of each product ordered**

|Column No|Column Name|Data Type|Size|Attributes|
| :-: | - | - | - | - |
|1|Order \_no|Varchar2|6|Foreign key referencessales\_order table|
|2|Product\_no|Varchar2|6|Foreign key references product\_master table|
|3|Qty\_ordered|Number|8||
|4|Qty\_disp|Number|8||
|5|Product\_rate|Number|10, 2||


**Data of sales\_order\_details**


|**Col-1**|**Col-2**|**Col-3**|**Col-4**|**Col-5**|
| - | - | - | - | - |
|O19001|P00001|4|4|525|
|O19001|P07965|2|1|8400|
|O19001|P07885|2|1|5250|
|O19002|P00001|10|0|525|
|O46865|P07868|3|3|3150|
|O46865|P07885|3|1|5250|
|O46865|P00001|10|10|525|
|O46865|P03453|4|4|1050|
|O19003|P03453|2|2|1050|
|O19003|P06734|1|1|12000|
|O46866|P07965|1|0|8400|
|O46866|P07975|1|0|1050|
|O19008|P00001|10|5|525|
|O19008|P07975|5|3|1050|

