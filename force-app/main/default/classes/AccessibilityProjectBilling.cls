global class AccessibilityProjectBilling{
    
     public static void callBillingService(String projectId, Decimal billingAmount) {
          // Setup username, password, billAmount, and projectId in BillingServiceProxy.project
          BillingServiceProxy bsp = new BillingServiceProxy();
          bsp.username = '{!$Credential.BillingServiceCredential.username}';
          bsp.password = '{!$Credential.BillingServiceCredential.username}';
          bsp.projectId = projectId;
          bsp.billAmount = billingAmount;
  
          Boolean resp = bsp.billProject();
  
          // If response is ok, set Accessibility Project Status = Complete
          if (resp) {
              Accessibility_Project__c ap = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :projectId LIMIT 1];
              ap.Status__c = 'Complete';
              update ap;
          }
     }
}