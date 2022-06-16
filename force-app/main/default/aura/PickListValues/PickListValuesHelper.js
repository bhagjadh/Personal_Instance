({
    helper : function(component){
    }
   /* fetchGenderPicklist : function(component){
        var action = component.get("c.getPickListValuesIntoList");
        action.setParams({
            objectType: component.get("v.sObjectName"),
            selectedField: component.get("v.fieldName")
        });
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.genpicklistValues", list);
        })
        $A.enqueueAction(action);
	},    
    fetchMarritalPicklist : function(component){
    var action = component.get("c.getPickListValuesIntoList");
        action.setParams({
            objectType: component.get("v.sObjectName"),
            selectedField: component.get("v.fieldName")
        });
        action.setCallback(this, function(response) {
            var list = response.getReturnValue();
            component.set("v.MarrpicklistValues", list);
        })
        $A.enqueueAction(action);
	}*/
})