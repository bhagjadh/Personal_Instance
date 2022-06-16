({
    selectPatient : function(component, event, helper){      
   // get the selected Patient from list  
     var getSelectPatient = component.get("v.patients");
   // call the event   
     var compEvent = component.getEvent("selectedpatientsLoadedEvent");
   // set the Selected Account to the event attribute.  
        compEvent.setParams({"recordByEvent" : getSelectPatient });  
   // fire the event  
        compEvent.fire();
   },
})