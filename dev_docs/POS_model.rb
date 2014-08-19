<<<<<<<<<<<<<<<<<<POS>>>>>>>>>>>>>>>>>>>

PRODUCT << Name, Price

CASHIER << Login, Name

TRANSACTION << Products, Quantity, Total_Cost

CUSTOMER << Name

Method(Transaction) for Cost
Method(Cashier) - transaction_per_cashier(cashier_name)
  > return list of transactions per cashier
Method(Sale): total_amount_sold(date_range)
  > return total income per range
Method(Sale): total_transactions(cashier_name)
  > return most efficient employee
Method(Customer): return_products(products)
  > return X money back
Method(Product): most_popular_item
  > return ordered list of quantity sold
Method(Product): least_popular_item
  > return ordered list of quantity returned


Product - has one transaction
 - has one cashier, has one customer
Customer - has_many products THROUGH transactions


CASHIER  - has_many_(CUSTOMER)_through many TRANSACTION
CUSTOMER - has_many(PRODUCT)_through many TRANSACTION
