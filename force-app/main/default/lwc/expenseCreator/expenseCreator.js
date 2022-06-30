import { LightningElement } from 'lwc';

//Apex methods
import createExpense from '@salesforce/apex/ExpenseController.createExpense';

export default class ExpenseCreator extends LightningElement {

    showRecurrenceQuantity = true;
    recurrenceQuantity = 1;
    disabledButton = true;

    get optionsCategory() {
        return [
            { label: 'Housing', value: 'Housing' },
            { label: 'Transportation', value: 'Transportation' },
            { label: 'Food', value: 'Food' },
            { label: 'Medical Healthcare', value: 'Medical Healthcare' },
            { label: 'Others', value: 'Others' }
        ];
    }

    get optionsRecurrence() {
        return [
            { label: 'Unique', value: 'Unique' },
            { label: 'Weekly', value: 'Weekly' },
            { label: 'Monthly', value: 'Monthly' }
        ];
    }

    handleChangeRecurrence(event){

        if(event.detail.value == 'Unique'){
            this.showRecurrenceQuantity = false;
            this.recurrenceQuantity = 1;
        }
        else{
            this.showRecurrenceQuantity = true;
            this.recurrenceQuantity = null;
        }

        this.verifyInputs();
    }

    verifyInputs(){

        var aux = false;

        let inputs = this.template.querySelectorAll(".inputFieldForm");

        for(let i = 0; i < inputs.length; i++){
            if(this.isEmpty(inputs[i].value)){
                aux = true;
            }
        }

        this.disabledButton = aux;
    }
    

    handleCreateExpenseButton(){
        

        let expenseRecord = {
            expenseName: this.template.querySelector("lightning-input[data-my-id='expenseName']").value,
            expenseDate: this.template.querySelector("lightning-input[data-my-id='expenseDate']").value,
            expenseAmount: parseFloat(this.template.querySelector("lightning-input[data-my-id='expenseAmount']").value).toFixed(2),
            expenseCategory: this.template.querySelector("lightning-combobox[data-my-id='expenseCategory']").value,
            expenseRecurrence: this.template.querySelector("lightning-combobox[data-my-id='expenseRecurrence']").value,
            expenseRecurrenceQuantity : parseInt(this.template.querySelector("lightning-input[data-my-id='recurrenceQuantity']").value)
        }

        console.log('expenseRecord:'+ JSON.stringify(expenseRecord));

        createExpense({expense: JSON.stringify(expenseRecord)})
        .then(result => {
            console.log('Data:'+ JSON.stringify(result));
        }) .catch(error => {
            console.log(error);
            this.error = error;
        }); 
        
    }

    //Returns true if the string is blank, null or made by only spaces 
    isEmpty(str) {
        return (!str || 0 === str.length || (str.trim()).length === 0 || str == undefined);
    }
}