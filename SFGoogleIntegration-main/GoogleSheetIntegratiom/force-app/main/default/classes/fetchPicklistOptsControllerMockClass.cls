@istest
global class fetchPicklistOptsControllerMockClass implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        request.setHeader('Accept', 'application/json');
        response.setHeader('Content-Type', 'application/json');

        response.setBody('{ "range": "Sheet1!A1:Y996",'+
							'"majorDimension": "ROWS",'+
							'"values": [[ "Id", "AccountId","LastName", "FirstName"],[ "0036F00003NX40RQAT", "0016F00003VVZ1kQAH", "parasa", "jagadeesh"] ]}');
        response.setStatusCode(200);
            return response;
    }
}