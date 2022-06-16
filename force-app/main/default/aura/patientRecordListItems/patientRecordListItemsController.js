({

    navToRecord : function(component, event, helper) {

        var navLink = component.find("navLink");

        var pageRef = {

            type: 'standard__recordPage',

            attributes: {

                actionName: 'view',

                objectApiName: 'Patient__c',

                recordId : component.get("v.patient.Id")

            },

        };
        var recID = component.get("v.patient.Id")
        console.log('Result before set Id'+recID);
        component.set("v.recordId",recID);
        navLink.navigate(pageRef, true);

    },

    hidePatientCareServices : function(component, event, helper){
        component.set("v.showPatientCareServices",false);
    },

    displayPatientCareServices : function(component, event, helper){
        component.set("v.showPatientCareServices",true);

        var patientId = event.getSource().get('v.value');
        console.log('Result before set Id'+patientId);
        console.log(component.get("v.patient.Id"));

        component.set('v.patintServcieColumns', [
            {label: 'Name', fieldName: 'Name', type: 'text'},
                {label: 'Therapy Service', fieldName: 'Therapy_Service__c', type: 'boolean'},
                {label: 'Nursing Service', fieldName: 'Nursing_Service__c', type: 'boolean'},
                {label: 'Specialty', fieldName: 'Specialty__c', type: 'text '},
                {label: 'Supportive Care', fieldName: 'Supportive_Care__c', type: 'text '},
                {label: 'Service', fieldName: 'Service__c', type: 'text '},
                {label: 'Preferred day of the week', fieldName: 'Preferred_day_of_the_week__c', type: 'text '},
                {label: 'Preferred time of day', fieldName: 'Preferred_time_of_day__c', type: 'date',
                    typeAttribute: {
                                    hour: "2-digit",
                                    minute: "2-digit",
                                    timeZone: "UTC"
                    }
                }
                

            ]);

        const action = component.get('c.getPatientServicesList');
        action.setParams({patientId : patientId});
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var allValues = response.getReturnValue();
                console.log("allValues--->>> " + JSON.stringify(allValues));
                component.set('v.patientServices', allValues);
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