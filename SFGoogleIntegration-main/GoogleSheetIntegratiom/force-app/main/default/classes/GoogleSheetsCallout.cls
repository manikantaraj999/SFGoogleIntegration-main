public class GoogleSheetsCallout {
    public static void gcallout(){
        //contact cnt = [select id,name,lastname,firstname,phone from contact limit 1];
           list<contact> clist = [select id,name,lastname,firstname,phone,email from contact];
        list<string> jsonlist = new list<string>();
        
        for(contact cs: clist){
            string sjson = '["'+cs.id+'","'+cs.name+'","'+cs.lastname+'","'+cs.firstname+'","'+cs.phone+'","'+cs.email+'"]';
            jsonlist.add(sjson);
        }
        
        string  myListStirng = string.join(jsonlist,',');
        system.debug('jsonlist'+myListStirng);
        if(myListStirng != null ){
            Http http = new Http();
			HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:googleSheetsSync/v4/spreadsheets/1SmQuvwXls68CIUp2GRcz2FrHfUfuIp1zFxsT2IikSJY/values/Sheet1:append?valueInputOption=RAW');
            request.setHeader('Accept', 'application/json');
           request.setHeader('Content-Type', 'application/json');
            request.setMethod('POST');
            string jsonstring = '{ '+
  				'"majorDimension": "DIMENSION_UNSPECIFIED",'+
                '"values": [["ID","Name","LastName","FirstName","Phone","Email"],'+myListStirng+' ],'+
                '"range": "Sheet1"}';
			
            request.setBody(jsonstring);
            HttpResponse res = http.send(request);
            system.debug('json body'+request.getBody());
            system.debug('statuscode'+res.getStatusCode());
            if(res.getStatusCode() == 200){
                system.debug('SUCCESS');
            }
        }
    }
}