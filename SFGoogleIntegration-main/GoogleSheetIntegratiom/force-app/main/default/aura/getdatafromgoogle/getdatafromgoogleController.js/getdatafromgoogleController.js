({
	doInit : function(component, event, helper) {
		var Action = component.get('c.getCredentials');
        
        Action.setCallback(this, function(response){
              var getcredname = response.getReturnValue();
            component.set('v.namedCred',getcredname);
                           });
        $A.enqueueAction(Action);
	},
    credName : function(component, event, helper){
		var namedcred = component.get('v.selectedName');
        var Action = component.get('c.sample');
       // alert('namedcred'+namedcred);
        Action.setParams({
            getnamedced : namedcred
        });
        Action.setCallback(this, function(response){
              var getobjnames = response.getReturnValue();
            component.set('v.objnames',getobjnames);
                           });
         $A.enqueueAction(Action);                  
    },
    getsheetdata : function(component, event, helper){
        
        var objname = component.get('v.selectedValue');
        var namedcred = component.get('v.selectedName');
        var Action = component.get('c.getdata');
       // alert('dufgejbfjes'+objname);
       // alert('dufgejbfjes'+namedcred);
        Action.setParams({
            objname : objname,
            getnamedced :namedcred
        });
        Action.setCallback(this, function(response){
              var state = response.getState();
            alert('Successfully Updated');
                           });
        $A.enqueueAction(Action);
    },
})