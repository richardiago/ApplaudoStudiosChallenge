import { LightningElement, track } from 'lwc';

//Apex methods
import getExpenses from '@salesforce/apex/ExpenseController.getExpenses';

//Custom Labels
import CL_EXPENSELIST_HEADER from '@salesforce/label/c.CL_EXPENSELIST_HEADER';

const columns = [
    { label: 'Name', fieldName: 'expenseName', hideDefaultActions: true},
    { label: 'Amount', fieldName: 'expenseAmount', type: 'currency', typeAttributes: { currencyCode: 'EUR', step: '0.001' }, hideDefaultActions: true, cellAttributes:{alignment: 'center'}},
    { label: 'Date', fieldName: 'expenseDate', type: 'date', hideDefaultActions: true, cellAttributes:{alignment: 'center'}},
    { label: 'Recurrence', fieldName: 'expenseRecurrence', hideDefaultActions: true, cellAttributes:{alignment: 'center'}},
    { label: 'Category', fieldName: 'expenseCategory', hideDefaultActions: true, cellAttributes:{alignment: 'center'}}
]

export default class ExpenseList extends LightningElement {

    @track data = [];
    columns = columns;

    Label = {CL_EXPENSELIST_HEADER};

    async connectedCallback(){
        this.data = await getExpenses({});
    }
}