({
    onPatientloaded : function(component, event, helper) {
        console.log('In Record Display Comp');
        var getPatients = component.get('v.patients');
        console.log('getPatients->'+getPatients);
        // get the selected Patient record from the COMPONETN event 	 
        //    var selectedPatientGetFromEvent = event.getParam("patients");
        //    console.log('selectedPatientGetFromEvent-->'+JSON.stringify(selectedPatientGetFromEvent));
        //    component.set("v.selectedpatientsLoadedEvent" , selectedPatientGetFromEvent);  

        var selectedPatientGetFromEvent = event.getParam("patients");
        console.log('selectedPatientGetFromEvent-->'+JSON.stringify(selectedPatientGetFromEvent));
        component.set("v.patients" , selectedPatientGetFromEvent);
        }
})
