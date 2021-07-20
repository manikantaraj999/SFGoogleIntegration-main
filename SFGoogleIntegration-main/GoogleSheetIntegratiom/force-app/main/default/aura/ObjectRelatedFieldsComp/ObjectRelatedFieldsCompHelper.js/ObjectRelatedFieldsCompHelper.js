({
    fetchPickListVal: function(component, fieldName, elementId) {
        var action = component.get("c.getselectOptions");
        action.setParams({
            "objObject": component.get("v.objInfo"),
            "fld": fieldName
        });
        var opts = [];
        action.setCallback(this, function(response) {
            if (response.getState() == "SUCCESS") {
                var allValues = response.getReturnValue();
                
                if (allValues != undefined && allValues.length > 0) {
                    opts.push({
                        class: "optionClass",
                        label: "--- None ---",
                        value: ""
                    });
                }
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
                }
                component.find(elementId).set("v.options", opts);
            }
        });
        $A.enqueueAction(action);
    },
    
    changeVal : function(component, event, helper) {
        var objname1 = component.get('v.selectedValue');
        var Action = component.get('c.geteobjectfields');
        Action.setParams({
            objname:''
        });
        Action.setCallback(this, function(response){
            var options=[];
            var fieldMap = response.getReturnValue();
            for(var k in fieldMap){
                options.push({value:k, label:fieldMap[k]});
            }
           // if(options.length > 0)
                component.set('v.option',options);
            //else
                //component.set('v.value',Null);
        });
        $A.enqueueAction(Action);		
    },
    
    namedCredentials : function(component, event, helper) {
        debugger;
        var Action = component.get('c.getCredentials');
        
        Action.setCallback(this, function(response){
            var cred = response.getReturnValue();
            component.set('v.namedCred',cred);
        });
        $A.enqueueAction(Action);		
    }
    
})