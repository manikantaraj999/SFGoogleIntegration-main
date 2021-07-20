({
        doInit: function(component, event, helper) {
            // helper.fetchPickListVal(component, 'Industry', 'accIndustry');
            
            helper.namedCredentials(component);
            var action = component.get('c.getselectOptions');
            action.setCallback(this,function(getObject){
                var state = getObject.getState();
                debugger;
                if(state === 'SUCCESS'){
                    var result = getObject.getReturnValue();
                    component.set('v.objInfo', result);
                    helper.changeVal(component, event, helper);
                }
            });
            $A.enqueueAction(action);
        },
        
        objName : function(component, event, helper){
            debugger;
            var objname1 = component.get('v.selectedValue');
            var action = component.get('c.geteobjectfields');
            action.setParams({
                objname:objname1
            });
            action.setCallback(this,function(getObject){
                var state = getObject.getState();
                debugger;
                if(state === 'SUCCESS'){
                    var options=[];
                    var fieldMap = getObject.getReturnValue();
                    for(var k in fieldMap){
                        options.push({value:k, label:fieldMap[k]});
                    }
                    component.set('v.option',options);
                    
                }
            });
            $A.enqueueAction(action);
        },
        
        
        getfieldnames : function(component, event, helper){
            debugger;
            var act = component.get('c.getacc');
            var namedCred = component.get('v.selectedName');
            var objname1 = component.get('v.selectedValue');
            var selectedfields = component.get("v.value");
            var fields = JSON.stringify(selectedfields);
            //alert('fields'+fields+objname1);
            act.setParams({
                objname : objname1,
                getfields : fields,
                devName : namedCred
            });
            act.setCallback(this,function(response){
                var state = response.getState();
                //alert('state'+state);
                 var value = response.getReturnValue();
                if(value !==''){
                    $A.get('e.force:refreshView').fire();
                        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": 'https://docs.google.com/spreadsheets/d/'+value
        });
        urlEvent.fire();
                }
                
                /*if(value === 'Account'){
                         $A.get('e.force:refreshView').fire();
                        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": 'https://docs.google.com/spreadsheets/d/1SmQuvwXls68CIUp2GRcz2FrHfUfuIp1zFxsT2IikSJY'
        });
        urlEvent.fire();
                }
                else if(value === 'Contact'){
                    $A.get('e.force:refreshView').fire();
                        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": 'https://docs.google.com/spreadsheets/d/1SmQuvwXls68CIUp2GRcz2FrHfUfuIp1zFxsT2IikSJY/edit#gid=1585450147'
        });
        urlEvent.fire();
                }
                else if(value === 'Opportunity'){
                    $A.get('e.force:refreshView').fire();
                        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": 'https://docs.google.com/spreadsheets/d/1SmQuvwXls68CIUp2GRcz2FrHfUfuIp1zFxsT2IikSJY/edit#gid=233872346'
        });
        urlEvent.fire();
                }*/
                
            });
            $A.enqueueAction(act);	
          
        },
    showSpinner: function(component, event, helper) {
        // remove slds-hide class from mySpinner
        var spinner = component.find("mySpinner");
        $A.util.removeClass(spinner, "slds-hide");
    },
     
    // function automatic called by aura:doneWaiting event 
    hideSpinner : function(component,event,helper){
        // add slds-hide class from mySpinner    
        var spinner = component.find("mySpinner");
        $A.util.addClass(spinner, "slds-hide");
    }
    })