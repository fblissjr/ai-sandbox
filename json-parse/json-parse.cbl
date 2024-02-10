```cobol
CBL CODEPAGE(DCBS)
       Identification division.
       ******************************************************************
       * Program ID: json_parse
       * Purpose: This program demonstrates simple JSON parsing 
       * in COBOL by defining JSON strings for client data 
       * and transactions, and then parsing these strings to extract 
       * and display data elements.
       * Author: [Authors' Name]
       * Date: [Date]
       ******************************************************************
         Program-id. json_parse.
       Data division.
        Working-storage section.
        
        ******************************************************************
        * Section: JSON Strings Definition
        * Description: This section declares and initializes JSON strings
        * representing client data and transactions. These strings
        * simulate input data for the program to process and parse.
        ******************************************************************
        
         1 jtxt-1047-client-data.
          3 pic x(16)  value '{"client-data":{'.
          ...
          
         1 jtxt-1047-transactions.
          3 pic x(16)  value '{"transactions":'.
          ...
          
         1 jtxt-1208 pic x(1000) value is all x'20'.
         
         77 txnum pic 999999 usage display  value zero .
         
         ******************************************************************
         * Section: Parsed Data Structures
         * Description: This section defines the data structures where parsed
         * JSON data will be stored. These correspond to the expected
         * format of the input JSON data.
         ******************************************************************
         
         1 client-data.
          3 account-num   pic 999,999,999,999.
          ...
          
          3 transactions.
           5 tx-record occurs 0 to 100 depending txnum.
            7 tx-uid       pic 99999 usage display.
            ...
            
       Procedure division.
           ****************************************************************
           * Procedure: Main
           * Description: Entry point of the program. Responsible for
           * invoking JSON parsing routines and displaying the parsed data.
           ****************************************************************
           
           Initialize jtxt-1208 all value.
           
           ****************************************************************
           * Convert client-data JSON string from EBCDIC to UTF-8,
           * parsing it, and loading the data into corresponding COBOL
           * data structures.
           ****************************************************************
           
           Move function display-of(
            function national-of(
            jtxt-1047-client-data) 1208)
             to jtxt-1208(1:function length(jtxt-1047-client-data)).

           Json parse jtxt-1208 into client-data
             with detail
             suppress transactions
             not on exception
               display "Successful JSON Parse"
           end-json.
           
           ****************************************************************
           * Display the parsed client information.
           ****************************************************************
           
           Display "Account Number:"
           Display "  " account-num
           Display "Balance:"
           Display "  " balance
           Display "Client Information: "
           Display "  Name:"
           Display "    " function display-of(name-last)
           Display "    " function display-of(name-first)
           Display "  Address:"
           Display "    " function display-of(addr-street)
           Display "    " function display-of(addr-city)
           Display "    " function display-of(addr-region)
           Display "    " function display-of(addr-code).
           
           Initialize jtxt-1208 all value.
           
           ****************************************************************
           * Convert transactions JSON string from EBCDIC to UTF-8,
           * parsing it, and loading the data into the transactions
           * data structures.
           ****************************************************************
           
           Move function display-of(
            function national-of(
            jtxt-1047-transactions) 1208)
             to jtxt-1208(1:function length(jtxt-1047-transactions)).

           Json parse jtxt-1208 into transactions
             with detail
             name tx-price is 'tx-priceinUS$'
             not on exception
               display "Successful JSON Parse"
           end-json.
           
           ****************************************************************
           * Display the parsed transactions information.
           ****************************************************************
           
           Display "Transactions:"
           Display "  Record 1:"
           Display "    TXID:        " tx-uid(1)
           Display "    Description: " tx-item-desc(1)
           Display "    Item ID:     " tx-item-uid(1)
           Display "    Price:       " tx-price(1)
           Display "    Comment:     "
             function display-of(tx-comment(1))
           Display "  Record 2:"
           Display "    TXID:        " tx-uid(2)
           Display "    Description: " tx-item-desc(2)
           Display "    Item ID:     " tx-item-uid(2)
           Display "    Price:       " tx-price(2)
           Display "    Comment:     "
             function display-of(tx-comment(2))

           Goback.
       End program json_parse.
```