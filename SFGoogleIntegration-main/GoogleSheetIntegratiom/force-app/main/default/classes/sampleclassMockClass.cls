@isTest
global class sampleclassMockClass implements HttpCalloutMock {
     global HttpResponse respond(HttpRequest request){
         /*Contact con = new Contact();
         con.LastName ='testlast';
         con.FirstName ='testfirst';
         insert con;*/
         
        HttpResponse response = new HttpResponse();
        request.setHeader('Accept', 'application/json');
        response.setHeader('Content-Type', 'application/json');

        response.setBody('{ "range": "Sheet1!A1:Y996",'+
							'"majorDimension": "ROWS",'+
							'"values": [[ "Id","LastName", "FirstName"],[ "0032w00000KRlvnAAD", "sunka", "saranya"] ]}');
        response.setStatusCode(200);
            return response;
    }

}