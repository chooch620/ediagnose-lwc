import { LightningElement, api, track } from 'lwc';

export default class PossibleConditions extends LightningElement {
    @api possibleConditions = [];
    @track activeSections = ['A', 'B'];

    isPossibleConditionsEmpty() {
        return this.possibleConditions.length === 0
    }
}