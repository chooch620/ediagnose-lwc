import { LightningElement, wire, api } from 'lwc';
import getPossibleConditions from '@salesforce/apex/SymptomListController.getPossibleConditions';

export default class GetConditionsButton extends LightningElement {
    @api selectedSymptoms;

    handleGetConditions() {
        console.log('Yeet');
    }

    @wire(getPossibleConditions, {symptoms: '$selectedSymptoms'})
    possibleConditions({ error, data }) {
        if (data) {
            console.log(`data: ${data}`);
        } else if (error) {
            console.log(`error: ${error}`);
            
        }
    }
}