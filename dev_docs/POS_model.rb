<<<<<<<<<<<<<<<<<<POS>>>>>>>>>>>>>>>>>>>

PRODUCT << Name, Price

CASHIER << Login, Name

TRANSACTION << Products, Quantity, Total_Cost

CUSTOMER << Name

UI/Methods:
1) Manager add product to POS
2) Manager create logins
3) Cashier selects product name from list and then the quantity, stores it in the transaction, at the end returns all products, their prices, and the transaction total to the customer (receipt)
4) Manager >> Method(Sale): total_amount_sold(date_range)
5) Manager >> Method(Sale): total_transactions(cashier_name)
6) Customer >> return_products_from_previous_transaction(products)
7) Method(Product): most_popular_item
  > return ordered list of quantity sold
8) Method(Product): least_popular_item
  > return ordered list of quantity returned

Product - has one transaction
 - has one cashier, has one customer
Customer - has_many products THROUGH transactions


CASHIER  - has_many_(CUSTOMER)_through many TRANSACTION
CUSTOMER - has_many(PRODUCT)_through many TRANSACTION

Method(Transaction) for Cost
Method(Manager) - transaction_per_cashier(cashier_name)
  > return list of transactions per cashier login
Method(Manager): total_amount_sold(date_range)
  > return total income per range
Method(Manager): total_transactions(cashier_name)
  > return most efficient employee
Method(Customer): return_products(products)
  > return X money back
Method(Product): most_popular_item
  > return ordered list of quantity sold
Method(Product): least_popular_item
  > return ordered list of quantity returned
