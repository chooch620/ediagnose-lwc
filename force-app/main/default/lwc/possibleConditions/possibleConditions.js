import { LightningElement, api } from 'lwc';

export default class PossibleConditions extends LightningElement {
    @api possibleConditions = [];

    connectedCallback() {
        console.log(`possibleConditions: ${JSON.stringify(this.possibleConditions)}`);
    }

    isPossibleConditionsEmpty() {
        return this.possibleConditions.length === 0
    }

    
}