/**
 * OpportunityTrigger - Bad practices example
 * Issues:
 * 1. Logic in trigger (should be in handler)
 * 2. No trigger context checks
 * 3. Direct SOQL queries
 * 4. No recursion prevention
 */
trigger OpportunityTrigger on Opportunity (before insert, after insert, before update, after update) {
    
    // Issue: All logic in trigger
    if(Trigger.isInsert) {
        for(Opportunity opp : Trigger.new) {
            // Issue: SOQL in loop
            Account acc = [SELECT Id, Name, AnnualRevenue FROM Account WHERE Id = :opp.AccountId];
            
            if(acc.AnnualRevenue > 1000000) {
                opp.StageName = 'Qualified';
            }
            
            // Issue: DML in trigger
            Task t = new Task(
                Subject = 'Follow up on ' + opp.Name,
                WhatId = opp.Id
            );
            insert t;
        }
    }
    
    // Issue: No bulkification
    if(Trigger.isUpdate) {
        for(Opportunity opp : Trigger.new) {
            if(opp.StageName == 'Closed Won') {
                // Issue: Callout not allowed in trigger
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://api.example.com/webhook');
                req.setMethod('POST');
                Http http = new Http();
                http.send(req);
            }
        }
    }
}

