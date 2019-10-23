import { LightningElement, api, track } from 'lwc';

export default class EDiagnoseContainer extends LightningElement {
    @api name;
    @api infermedicaId;
    @track isSelected = false;

    handleClick() {
        this.isSelected = !this.isSelected;
    }

}