@istest
global class fetchPicklistOptsControllerMockClassFail implements HttpCalloutMock {
      global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
          request.setHeader('Accept', 'application/json');
        response.setHeader('Content-Type', 'application/json');
       response.setStatusCode(400);
            return response;
    }
}