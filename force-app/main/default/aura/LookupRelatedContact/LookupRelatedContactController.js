({ 
    selectedLookupChanged:function(component, event, helper) { 
        
        component.set('v.columns', [
            {label: 'Contact Name', fieldName: 'Name', editable: true, type: 'text'},
            {label: 'Phone', fieldName: 'Phone', type: 'phone'}
        ]);
        
        var aId = component.get("v.selectedLookUpRecord").Id;
        
        var action=component.get('c.getCon');
        action.setParams({accId : aId});
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                var rows1 = response.getReturnValue();
                console.log('rows1 ->> ' + rows1);
                component.set("v.data", rows1);
            }
        });
        $A.enqueueAction(action);
    } 
})