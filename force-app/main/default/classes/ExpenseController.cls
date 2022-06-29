public without sharing class ExpenseController {
    
    @AuraEnabled
    public static List<ExpenseVO> getExpenses(){

        List<ExpenseVO> expenseList = new List<ExpenseVO>();

        for(Expense__c exp : [SELECT Id, Name, Amount__c, Expense_Date__c, Category__c, Recurrence__c FROM Expense__c ORDER BY Name]){
            expenseList.add(new ExpenseVO(exp));
        }

        return expenseList;
    }

    @AuraEnabled
    public static void createExpense(){

    }


    public class ExpenseVO{

        @AuraEnabled public String expenseId;
        @AuraEnabled public String expenseName;
        @AuraEnabled public Date expenseDate;
        @AuraEnabled public Decimal expenseAmount;
        @AuraEnabled public String expenseCategory;
        @AuraEnabled public String expenseRecurrence;
        @AuraEnabled public String expenseRecurrenceQuantity;

        public ExpenseVO(Expense__c exp){

            this.expenseId         = exp.Id;
            this.expenseName       = exp.Name;
            this.expenseAmount     = exp.Amount__c;
            this.expenseDate       = exp.Expense_Date__c;
            this.expenseCategory   = exp.Category__c;
            this.expenseRecurrence = exp.Recurrence__c;
        }
    }
}
