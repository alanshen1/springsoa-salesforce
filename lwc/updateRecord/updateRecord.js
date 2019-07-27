/**
 * Created by spring4 on 30-05-2019.
 */

import { LightningElement, api } from 'lwc';
export default class CreateRecord extends LightningElement {
@api recordId;
@api objectApiName;

    handleSubmit() {
        // Code that runs when form is submitted.
    }

    handleCancel(){
        console.log('cancel called');
    }
}