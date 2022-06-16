({
    // code in the helper is reusable by both
    // the controller.js and helper.js files
    /*handleSearch: function( component, searchTerm ) {
        console.log("Helper searchTerm"+searchTerm);
        var action = component.get( "c.searchPatients" );
        action.setParams({
            "searchKey": searchTerm
        });
        action.setCallback( this, function( response ) {
            var result = response.getReturnValue();
            console.log('Result create'+JSON.stringify(result));
            var event = $A.get( "e.c:patientLoaded" );
            event.setParams({
                "patients": response.getReturnValue()
            });
            event.fire();
        });
        $A.enqueueAction( action );
    }*/

    SearchHelper : function(component, event, helper) {
        console.log('test');
        var action = component.get('c.fetchPatientInfo');
         action.setParams({ searchKey : component.get("v.searchKeyword"),
                          });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + JSON.stringify(allValues));
                //component.set('v.activeSections', allValues.Name);
                component.set('v.patientList', allValues);
            }
            else if(state === "ERROR") {
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error Message: " + errors[0].message);
                    }
                }
                else{
                    console.log("Unknown Error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})