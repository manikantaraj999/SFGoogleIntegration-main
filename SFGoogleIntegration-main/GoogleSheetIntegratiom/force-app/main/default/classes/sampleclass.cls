public class sampleclass {
    @AuraEnabled
    public static list<string> sample(string getnamedced){
        system.debug('getnamedced'+getnamedced);
        //NamedCredential namedCred = [SELECT Id, DeveloperName,MasterLabel  FROM NamedCredential where DeveloperName =:getnamedced];
        //string gsheetaccname = namedCred.MasterLabel; 
        list<google_sheet__c> getgsheets =[SELECT id,name,Dev_Name__c FROM google_sheet__c where Dev_Name__c = :getnamedced];
        list<string> sobjnames = new list<string>();
        for(google_sheet__c gs : getgsheets){
            string sobjname = gs.name;
            sobjnames.add(sobjname);
        }
        
        return sobjnames;
            }
    
    @AuraEnabled
    public static void getdata(string objname,string getnamedced){
        Schema.SObjectType sobjname = Schema.getGlobalDescribe().get(objname);
       
        
		google_sheet__c getgsheet =[SELECT id,name,Dev_Name__c,google_Sheet_ext_Id__c from google_sheet__c where name=:objname AND Dev_Name__c=:getnamedced];
		//String namedCred =  getgsheet.google_account_name__c;
        string sheetid = getgsheet.google_Sheet_ext_Id__c;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:'+getnamedced+'/v4/spreadsheets/'+sheetid+'/values/sheet1');
        request.setHeader('Accept', 'application/json');
        request.setHeader('Content-Type', 'application/json');
        request.setMethod('GET');
        HttpResponse res = http.send(request);
         updateSF sheetRows  = (updateSF )JSON.deserialize(res.getbody(), updateSF.class); // Jsonstring is the above JSON
        system.debug('sheetRows::::'+sheetRows);
        list<string> apiNames = sheetRows.values[0];
        system.debug('apiNames:'+apiNames);
        List<sObject> objlist = new List<sObject>();
        for(integer i=1; i<sheetRows.values.size(); i++){
             sObject acnt = Schema.getGlobalDescribe().get(objname).newSObject();
            //contact acnt = new contact();
             system.debug('sheetRows.values[i]:'+sheetRows.values[i]);
            list<string> eachRow = sheetRows.values[i];
            for(integer j=0; j<eachRow.size(); j++)
            {
                string eachCell = eachRow[j];
                if(eachCell != 'null')
                acnt.put(apiNames[j], eachCell);
            }
            objlist.add(acnt);
        
        }
        if(objlist.size()>0)
        	Update objlist; //Database.Upsert to be used
    }

     public class updateSF{
        public string range;
        public string majorDimension;
        public list<list<string>> values;
    }
      @AuraEnabled
    public static List<NamedCredential> getCredentials(){
       List<NamedCredential> namedCred = [SELECT Id, DeveloperName,MasterLabel  FROM NamedCredential]; 
        return namedCred;
    }

    
}