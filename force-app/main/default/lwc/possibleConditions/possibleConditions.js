import { LightningElement, api } from 'lwc';

export default class PossibleConditions extends LightningElement {
    @api possibleConditions = [];

    connectedCallback() {
        console.log(`c: ${this.possibleConditions[0].Name}`);
        console.log(`possibleConditions: ${JSON.stringify(this.possibleConditions.detail)}`);
    }

    isPossibleConditionsEmpty() {
        return this.possibleConditions.length === 0
    }

    /**
     * Currently, the conditions are not showing. I think this may because InfermedicaResponseHandlerController
     * returns a list of InfermedicaCondition instead of Condition__c.
     */
    
}