Generate Java classes for purchase items and orders.

## Order Fields
- List of line items to reference the order
- The total amount of the order
- The status of the order: Received, Rejected and Accepted

For each line item:
- ItemID field that is associated to the Item in the catalog
- Item Price
- Item Quantity

## Example
An order with Accepted status could contain 2 line items:
- ItemID: 1, ItemPrice: 10, ItemQuantity: 5
- ItemID: 2, ItemPrice: 19.99, ItemQuantity: 2

The order TotalAmount is 89.98

## Additional Rules
- Maximum 10 line items per order
- Minimum 1 line item per order
- Each line item must have a quantity greater than 0
- Each item price must be greater than 0

Also generate a class diagram using Mermaid Markdown.
Think step by step, and revalidate answers.