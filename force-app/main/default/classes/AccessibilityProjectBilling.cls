global class AccessibilityProjectBilling{
    
     public static void callBillingService(String projectId, Decimal billingAmount) {

          // Opret en instans af BillingServiceProxy.project
          BillingServiceProxy.project project = new BillingServiceProxy.project();

          // Tildel værdier til variablerne i project
          project.username = '{!$Credential.BillingServiceCredential.username}';
          project.password = '{!$Credential.BillingServiceCredential.password}';
          project.projectid = projectId;
          project.billAmount = billingAmount;

          // Kald billProject-metoden og send project som parameter
          BillingServiceProxy.InvoicesPortSoap11 service = new BillingServiceProxy.InvoicesPortSoap11();
          String response = service.billProject(project);

          // Hvis responsen er "success", opdater projektstatus
          if (response == 'success') {
               Accessibility_Project__c ap = [SELECT Id, Status__c FROM Accessibility_Project__c WHERE Id = :projectId LIMIT 1];
               ap.Status__c = 'Complete';
               update ap;
          }
     }
}