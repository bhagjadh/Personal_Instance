({
   /* onInit: function( component, event, helper ) {
        var searchTerm = component.get( "v.searchTerm" );
        console.log("searchTerm"+searchTerm);
        helper.handleSearch( component, searchTerm );
    },
    onSearchTermChange: function( component, event, helper ) {
        var searchTerm = component.get( "v.searchTerm" );
        var delayMillis = 500;
        var timeoutId = component.get( "v.searchTimeoutId" );
        clearTimeout( timeoutId );
        timeoutId = setTimeout( $A.getCallback( function() {
            helper.handleSearch( component, searchTerm );
        }), delayMillis );
        component.set( "v.searchTimeoutId", timeoutId );
    }*/

    onSearchTermChange : function( component, event, helper ) {
        console.log('test controller');
        var selectedLimit = component.find('searchField').get('v.value');
        console.log('selectedLimit->'+selectedLimit);
        component.set('v.searchKeyword', selectedLimit);
        helper.SearchHelper(component, event);
    }
})