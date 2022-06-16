({
	 doInit: function(component, event, helper) {        
         helper.setPicklistValues(component,event);
         helper.resetInputForm(component);       
    },
     
    
    clickCreate : function(component, event, helper) {
        var patient = component.get("v.patientInfo");
        var therapyPatient = component.get("v.patientTherapyServiceInfo");
        var nusrningPatient = component.get("v.patientNursingServiceInfo"); 

        var patientDetails ={
            patientsInfo: patient,
            therapypatientCareServices: therapyPatient,
            nursingpatientCareServices: nusrningPatient
        }
        helper.savePatientInfo(component, event, patientDetails);
    },

    handleValueChange : function(component, event, helper) {
        helper.valueChange(component, event);
    }

})