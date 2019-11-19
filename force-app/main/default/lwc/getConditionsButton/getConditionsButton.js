import { LightningElement, api, track } from 'lwc';
import getPossibleConditions from '@salesforce/apex/SymptomListController.getPossibleConditions';

export default class GetConditionsButton extends LightningElement {
    @api selectedSymptoms; 

    handleGetConditions(event) {
        getPossibleConditions({symptoms : this.selectedSymptoms})
            .then(result => {
                event.preventDefault();
                let conditions = result;
                const diagnosisReceivedEvent = new CustomEvent('DiagnosisReceivedEvent', { detail: {possibleConditions:conditions} });
                this.dispatchEvent(diagnosisReceivedEvent);
            })
            .catch(error => {
                console.log(`Error getting conditions getConditionsButton: ${error}`);
            });
    }
}