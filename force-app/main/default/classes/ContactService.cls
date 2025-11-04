/**
 * @description Service class for Contact operations
 * @author DevOps Team
 * @date 2024-10-01
 * 
 * This class demonstrates GOOD practices:
 * - Proper bulkification
 * - Error handling
 * - Security checks
 * - No hardcoded values
 */
public with sharing class ContactService {
    
    private static final Integer BATCH_SIZE = 200;
    
    /**
     * @description Updates contact mailing addresses in bulk
     * @param contactIds List of contact IDs to update
     * @param newCity New city value
     * @param newState New state value
     * @return List of updated contacts
     * @throws ContactServiceException if validation fails
     */
    public static List<Contact> updateMailingAddress(
        List<Id> contactIds, 
        String newCity, 
        String newState
    ) {
        // Input validation
        if(contactIds == null || contactIds.isEmpty()) {
            throw new ContactServiceException('Contact IDs cannot be null or empty');
        }
        
        if(String.isBlank(newCity) || String.isBlank(newState)) {
            throw new ContactServiceException('City and State are required');
        }
        
        try {
            // Bulk SOQL - one query for all records
            List<Contact> contacts = [
                SELECT Id, MailingCity, MailingState 
                FROM Contact 
                WHERE Id IN :contactIds
                WITH SECURITY_ENFORCED
            ];
            
            // Bulk processing
            for(Contact con : contacts) {
                con.MailingCity = newCity;
                con.MailingState = newState;
            }
            
            // Security check before DML
            if(!Schema.sObjectType.Contact.isUpdateable()) {
                throw new ContactServiceException('Insufficient permissions to update contacts');
            }
            
            // Bulk DML - one operation
            update contacts;
            
            return contacts;
            
        } catch(DmlException e) {
            System.debug(LoggingLevel.ERROR, 'DML Error: ' + e.getMessage());
            throw new ContactServiceException('Failed to update contacts: ' + e.getMessage());
        } catch(QueryException e) {
            System.debug(LoggingLevel.ERROR, 'Query Error: ' + e.getMessage());
            throw new ContactServiceException('Failed to query contacts: ' + e.getMessage());
        }
    }
    
    /**
     * @description Custom exception class for ContactService
     */
    public class ContactServiceException extends Exception {}
}

