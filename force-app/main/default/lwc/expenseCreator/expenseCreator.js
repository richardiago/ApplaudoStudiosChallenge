import { LightningElement } from 'lwc';

export default class ExpenseCreator extends LightningElement {

    showRecurrenceQuantity = true;

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
}