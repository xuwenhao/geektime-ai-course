Attribute VB_Name = "ģ��1"
Option Explicit

Sub GetOpenAIResults()
    
    'Declare variables
    Dim wb As Workbook
    Dim ws As Worksheet
    Dim lastRow As Long
    Dim i As Long
    Dim productTitle As String
    Dim response As String
    Dim request As Object
    Dim url As String
    Dim apiKey As String
    Dim requestJSON As String
    Dim Json As Object

    'Set variables
    Set wb = ThisWorkbook
    Set ws = wb.ActiveSheet
    lastRow = ws.Cells(ws.Rows.Count, "A").End(xlUp).Row
    apiKey = "YOUR OPENAI API KEY HERE"
    url = "https://api.openai.com/v1/engines/text-davinci-003/completions"

    
    'Loop through each row in column A
    For i = 2 To lastRow
        
        'Get the product title from column A
        productTitle = ws.Cells(i, 1).Value
        
        'Set up the OpenAI API request
        Set request = CreateObject("MSXML2.XMLHTTP")
        request.Open "POST", url, False
        request.setRequestHeader "Content-Type", "application/json"
        request.setRequestHeader "Authorization", "Bearer " & apiKey
        
        'Send the request to OpenAI API
        requestJSON = "{""prompt"": ""Consideration proudct : " & productTitle & "\r\n1. Compose human readable product title used on Amazon in english within 20 words.\r\n2. Write 5 selling points for the products in Amazon.\r\n3. Evaluate a price range for this product in U.S.\r\n\r\nOutput the result in json format with three properties called title, selling_points and price_range.\r\n"",""temperature"": 0.7,""max_tokens"": 1024}"
        request.send requestJSON
        'Get the response from OpenAI API
        response = request.responseText
                
        Set Json = JsonConverter.ParseJson(response)
        Set Json = JsonConverter.ParseJson(Json("choices")(1)("text"))

        'Insert the JSON output into column B
        ws.Cells(i, 2).Value = Json("title")
        ws.Cells(i, 3).Value = ConcatenateArrayToString(Json("selling_points"))
        ws.Cells(i, 4).Value = Json("price_range")
        
    Next i
    
End Sub


Function ConcatenateArrayToString(arr) As String
    Dim result As String
    Dim i As Long
    
    'Assuming the array is stored in a variable named "arr"
    
    For i = 1 To 5
        result = result & arr(i) & vbCrLf  'Use vbCrLf to add a line break after each element
    Next i
    
    'The "result" variable now contains the concatenated string
    ConcatenateArrayToString = result
End Function
