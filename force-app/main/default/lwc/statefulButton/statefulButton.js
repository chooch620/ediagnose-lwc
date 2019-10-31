import { LightningElement, api, track } from 'lwc';

export default class statefulButton extends LightningElement {
    @api name;
    @track isSelected = false;

    handleClick() {
        this.isSelected = !this.isSelected;
    }

}