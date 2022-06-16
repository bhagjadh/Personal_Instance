({
    // code in the helper is reusable by both
    // the controller.js and helper.js files
    handleSearch: function( component, searchTerm ) {
        console.log('In HandleSearch()');
        var action = component.get( "c.fetchPatientInfo" );
        action.setParams({
            searchTerm: searchTerm
        });

        action.setCallback( this, function( response ) {
            console.log('Result->'+JSON.stringify( response.getReturnValue()));

            var event = $A.get( "e.c:patientLoaded" );
            event.setParams({
                "patients": response.getReturnValue()
            });

            console.log('Event->'+JSON.stringify(event));
            event.fire();
        });
        $A.enqueueAction( action );
    }
})