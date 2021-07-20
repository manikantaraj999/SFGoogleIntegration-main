public class MailService {
    @AuraEnabled public static string recordId{get;set;}
    @AuraEnabled
    public static void setMailService(string recId){
        recordId = recId;
        system.debug('recId::'+recId);
        user userName = [select Id, Name, LastName,Firstname,Email from User where Id = :UserInfo.getUserId()];
        list<Employee__c> emp = [Select Id,Name,Email__c,Offer_Status__c,Offer_Release_Date__c from Employee__c where Id=:recId];
        system.debug('emp::'+emp);
        Messaging.SingleEmailmessage mail = new Messaging.SingleEmailMessage();
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        String fileName = 'offerLetter.pdf';
        attachment.setFileName(fileName);
        PageReference pageRef = new PageReference('/apex/EmpPage');
        Blob csvBlob = MailService.generatePDF(recId);
        attachment.setBody(csvBlob);
        string[] toAddresses = new string[] {emp[0].Email__c};
            system.debug('toAddresses::'+toAddresses);
        string subject = 'OFFER LETTER';
        mail.setToAddresses(toAddresses);
        mail.setSubject(subject);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[]{attachment});
        mail.setPlaintextBody('Dear '+ emp[0].Name +  ',\nThis is OfferLetter. Please revert back with signature copy of this letter.\nRegards\n'
                              +userName.FirstName );
        for(Employee__c e:emp){
            if(mail !=null){
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
                if(e.Offer_Status__c ==null){
                e.Offer_Status__c = 'Released';
                e.Offer_Release_Date__c = system.today();
                    }
            }
            
        }
        update emp;
        
    }
    
    public static Blob generatePDF(String recordId) {
        // create a virtual page
        PageReference page = new PageReference('/apex/EmpPage');
        // add our record id
        page.getParameters().put('Id', recordId);
        // generate and PDF blob
        // You can save this blob as a file, document, or attachment!
        return page.getContentAsPDF();
    }
}