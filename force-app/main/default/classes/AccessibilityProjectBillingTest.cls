/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccessibilityProjectBillingTest {

    @isTest
    static void testCallBillingService() {
        // Set up test data
        Accessibility_Project__c project = new Accessibility_Project__c();
        project.Amount__c = 100.00;
        insert project;

        Test.startTest();
        
        // Set mock callout
        Test.setMock(WebServiceMock.class, new BillingCalloutServiceMock());

        // Call the method
        AccessibilityProjectBilling.callBillingService(project.Id, project.Amount__c);

        Test.stopTest();
        
        // Verify the project status
        project = [SELECT Status__c FROM Accessibility_Project__c WHERE Id = :project.Id];
        System.assertEquals('Complete', project.Status__c, 'Project status should be Complete');
    }
}