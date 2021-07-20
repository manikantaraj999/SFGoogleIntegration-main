@istest
private class fetchPicklistOptsControllerTest {

    @istest static void TestGetselectOptions(){
        list<string> fieldslist =new list<string>();
        fieldslist.add('Id');
        fieldslist.add('LastName');
        fieldslist.add('FirstName');
        
        Test.startTest();
        test.setMock(HttpCalloutMock.class , new fetchPicklistOptsControllerMockClass());
        fetchPicklistOptsController.getacc('Lead',fieldslist, 'SalesforceToSmartdataOnsiteAccount');
        fetchPicklistOptsController.getCredentials();
        fetchPicklistOptsController.getselectOptions();
        fetchPicklistOptsController.geteobjectfields('Lead');
		Test.stopTest();
    }  
    
      @istest static void TestGetselectOptionsList(){
        list<string> fieldslist =new list<string>();
        fieldslist.add('Id');
        //fieldslist.add('Id');
        fieldslist.add('LastName');
        fieldslist.add('FirstName');

		google_sheet__c gSheet = new google_sheet__c();
        gSheet.Name = 'Contact';
		gSheet.Dev_Name__c = 'SalesforceToSmartdataOnsiteAccount';
        gSheet.Google_url__c = 'https://docs.google.com/spreadsheets/d/1acRexpF9t88TqIBUzvuf1kpPbu7on5od7uwLT9HsoFQ/edit';
        gSheet.google_Sheet_ext_Id__c = '1acRexpF9t88TqIBUzvuf1kpPbu7on5od7uwLT9HsoFQ';
        insert gSheet;
        
        String devName = gSheet.Dev_Name__c;
          
        Test.startTest();
        test.setMock(HttpCalloutMock.class , new fetchPicklistOptsControllerMockClass());
        fetchPicklistOptsController.getacc('Contact',fieldslist, devName);
        fetchPicklistOptsController.getCredentials();
        fetchPicklistOptsController.getselectOptions();
        fetchPicklistOptsController.geteobjectfields('Contact');
		Test.stopTest();
    } 
    
    @istest static void TestGetselectOptionsListFail(){
        list<string> fieldslist =new list<string>();
        fieldslist.add('Id');
        fieldslist.add('AccountId');
        fieldslist.add('Name');
        
        google_sheet__c gSheet = new google_sheet__c();
        gSheet.Name = 'Contact';
		gSheet.Dev_Name__c = 'SalesforceToSmartdataOnsiteAccount';
        gSheet.Google_url__c = 'https://docs.google.com/spreadsheets/d/1acRexpF9t88TqIBUzvuf1kpPbu7on5od7uwLT9HsoFQ/edit';
        gSheet.google_Sheet_ext_Id__c = '1acRexpF9t88TqIBUzvuf1kpPbu7on5od7uwLT9HsoFQ';
        insert gSheet;
          
        String devName = gSheet.Dev_Name__c;
        
        Test.startTest();
        test.setMock(HttpCalloutMock.class , new fetchPicklistOptsControllerMockClassFail());
        fetchPicklistOptsController.getacc('Contact',fieldslist, devName);
        fetchPicklistOptsController.getCredentials();
        fetchPicklistOptsController.getselectOptions();
        fetchPicklistOptsController.geteobjectfields('Contact');
		Test.stopTest();
    } 
    
 
}