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
    public static ResponseVO createExpense(String expense){

        ExpenseVO exp = (ExpenseVO) JSON.deserialize(expense, ExpenseVO.class);

        List<Expense__c> expenseToInsert = new List<Expense__c>();

        if(exp.expenseRecurrence == 'Unique') expenseToInsert.add(createUniqueExpense(exp));
        else if (exp.expenseRecurrence == 'Weekly') expenseToInsert = createWeeklyExpense(exp);
        else if (exp.expenseRecurrence == 'Monthly') expenseToInsert = createMonthlyExpense(exp);

        ResponseVO resp = new ResponseVO();

        try{
            insert expenseToInsert;
            resp.status = true;
        }
        catch(Exception e){
            resp.status = false;
            resp.errorMessage = e.getMessage();
        }

        return resp;
    }

    public static Expense__c createUniqueExpense(ExpenseVO expVO){

        return new Expense__c(Name = expVO.expenseName, Amount__c = expVO.expenseAmount, Expense_Date__c = expVO.expenseDate, Category__c = expVO.expenseCategory, Recurrence__c = expVO.expenseRecurrence);
    }

    public static List<Expense__c> createWeeklyExpense(ExpenseVO expVO){

        Datetime temp = DateTime.newInstance(expVO.expenseDate, Time.newInstance(0, 0, 0, 0));
        Date aux;

        switch on temp.format('EEEE') {
            when 'Friday' {
                aux = expVO.expenseDate.addDays(7);
            }
            when 'Thursday' {
                aux = expVO.expenseDate.addDays(1);
            }
            when 'Wednesday' {
                aux = expVO.expenseDate.addDays(2);
            }
            when 'Tuesday' {
                aux = expVO.expenseDate.addDays(3);
            }
            when 'Monday' {
                aux = expVO.expenseDate.addDays(4);
            }
            when 'Sunday' {
                aux = expVO.expenseDate.addDays(5);
            }
            when 'Saturday' {
                aux = expVO.expenseDate.addDays(6);
            }
            when else {
                
            }
        }
        
        List<Expense__c> expenseToInsert = new List<Expense__c>();

        for(Integer i = 0; i < expVO.expenseRecurrenceQuantity; i++){

            expenseToInsert.add(new Expense__c(
                Name            = expVO.expenseName,
                Amount__c       = expVO.expenseAmount,
                Category__c     = expVO.expenseCategory,
                Recurrence__c   = expVO.expenseRecurrence,
                Expense_Date__c = aux.addDays(i*7)
            ));

        }

        return expenseToInsert;
    }

    public static List<Expense__c> createMonthlyExpense(ExpenseVO expVO){

        List<Expense__c> expenseToInsert = new List<Expense__c>();

        for(Integer i = 0; i < expVO.expenseRecurrenceQuantity; i++){

            expenseToInsert.add(new Expense__c(
                Name            = expVO.expenseName,
                Amount__c       = expVO.expenseAmount,
                Category__c     = expVO.expenseCategory,
                Recurrence__c   = expVO.expenseRecurrence,
                Expense_Date__c = expVO.expenseDate.day() < 15 ? (Date.newInstance(expVO.expenseDate.year(), expVO.expenseDate.month(), 15)).addMonths(i) : (Date.newInstance(expVO.expenseDate.year(), expVO.expenseDate.month(), 15)).addMonths(i+1)
            ));
        }

        return expenseToInsert;
    }

    public class ExpenseVO{

        @AuraEnabled public String expenseId;
        @AuraEnabled public String expenseName;
        @AuraEnabled public Date expenseDate;
        @AuraEnabled public Decimal expenseAmount;
        @AuraEnabled public String expenseCategory;
        @AuraEnabled public String expenseRecurrence;
        @AuraEnabled public Integer expenseRecurrenceQuantity;
    
        public ExpenseVO(){}

        public ExpenseVO(Expense__c exp){

            this.expenseId         = exp.Id;
            this.expenseName       = exp.Name;
            this.expenseAmount     = exp.Amount__c;
            this.expenseDate       = exp.Expense_Date__c;
            this.expenseCategory   = exp.Category__c;
            this.expenseRecurrence = exp.Recurrence__c;
        }
    }

    public class ResponseVO{
        @AuraEnabled public Boolean status;
        @AuraEnabled public String errorMessage;
    }
}
