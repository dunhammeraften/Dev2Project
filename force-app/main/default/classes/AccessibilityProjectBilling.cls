global class AccessibilityProjectBilling{
    
     public static void callBillingService(String projectId, Decimal billingAmount) {
          // Setup username, password, billAmount, and projectId in BillingServiceProxy.project
          BillingServiceProxy.project project = new BillingServiceProxy.project();

          project.username = '{!$Credential.BillingServiceCredential.username}';
          project.password = '{!$Credential.BillingServiceCredential.username}';
          project.projectId = projectId;
          project.billAmount = billingAmount;

          BillingServiceProxy.InvoicesPortSoap11 stub = new BillingServiceProxy.InvoicesPortSoap11();
          
          String status = stub.billProject(project);
  
          // If response is ok, set Accessibility Project Status = Complete
          if (status == 'OK') {
              Accessibility_Project__c ap = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :projectId LIMIT 1];
              ap.Status__c = 'Complete';
              update ap;
          }
     }
}