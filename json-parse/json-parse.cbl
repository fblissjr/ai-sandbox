```python
import json

# Defining the COBOL hardcoded JSON strings for client data and transactions
jtxt_1047_client_data = (
    '{"client-data": {'
    ' "account-num":123456789012,'
    ' "balance":-125.53,'
    ' "billing-info":{'
    '  "name-first":"Matt",'
    '  "name-last":"CUZ",'
    '  "addr-street":"2455 South Rd",'
    '  "addr-city":"Pok",'
    '  "addr-region":"New York",'
    '  "addr-code":"12601"'
    '  }'
    ' }'
    '}'
)

jtxt_1047_transactions = (
    '{"transactions":'
    ' {"tx-record":'
    '  ['
    '   {'
    '    "tx-uid":107,'
    '    "tx-item-desc":"prod a ver 1",'
    '    "tx-item-uid":"ab142424",'
    '    "tx-priceinUS$":12.34,'
    '    "tx-comment":"express shipping"'
    '   },'
    '   {'
    '    "tx-uid":1904,'
    '    "tx-item-desc":"prod g ver 2",'
    '    "tx-item-uid":"gb051533",'
    '    "tx-priceinUS$":833.22,'
    '    "tx-comment":"digital download"'
    '   } '
    '  ]'
    ' }'
    '}'
)

# Parse the client data JSON string and store the results
client_data = json.loads(jtxt_1047_client_data)['client-data']

# Displaying the parsed client information
print("Account Number:")
print("  ", client_data['account-num'])
print("Balance:")
print("  ", client_data['balance'])
print("Client Information: ")
print("  Name:")
print("    ", client_data['billing-info']['name-last'])
print("    ", client_data['billing-info']['name-first'])
print("  Address:")
print("    ", client_data['billing-info']['addr-street'])
print("    ", client_data['billing-info']['addr-city'])
print("    ", client_data['billing-info']['addr-region'])
print("    ", client_data['billing-info']['addr-code'])

# Parse the transactions JSON string
transactions_data = json.loads(jtxt_1047_transactions)['transactions']['tx-record']

# Displaying the parsed transaction records
print("Transactions:")
for i, transaction in enumerate(transactions_data, start=1):
    print(f"  Record {i}:")
    print("    TXID:       ", transaction['tx-uid'])
    print("    Description:", transaction['tx-item-desc'])
    print("    Item ID:    ", transaction['tx-item-uid'])
    print("    Price:      ", transaction['tx-priceinUS$'])
    print("    Comment:    ", transaction['tx-comment'])
```