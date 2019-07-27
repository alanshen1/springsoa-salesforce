/**
 * Created by Spring7 on 7/9/2019.
 */

import {LightningElement,api,wire,track} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CASE_OBJECT from '@salesforce/schema/Case';
import REASON_FIELD from '@salesforce/schema/Case.Reason';
import apexMethod from '@salesforce/apex/PanoramaHelpController.getObjectName';
import createCaseRecord from '@salesforce/apex/PanoramaHelpController.createCaseRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PanoramaHelp extends LightningElement {
    @api recordId;
    @track value;
    @track objectName;

    @wire(getObjectInfo, { objectApiName: CASE_OBJECT })
        objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: REASON_FIELD})
        ReasonPicklistValues;

    @wire(apexMethod, { currentRecordId: '$recordId' })
    wiredObjectName({ error, data }) {
        if (data) {
            if(data === 'Undefined'){
                this.objectName = '';
                //this.template.querySelector('[data-id="relatedTo"]').disabled=true;
                this.template.querySelector('[data-id="sendToSupport"]').disabled=true;
            }else{
                this.objectName = data;
                //this.template.querySelector('[data-id="relatedTo"]').disabled=false;
                this.template.querySelector('[data-id="sendToSupport"]').disabled=false;
            }
        } else if (error) {
           console.log('error');
        }
    };

    handleChange(event) {
        this.value = event.detail.value;
    }

    sendToSupport(event){
        createCaseRecord({relatedTo:this.objectName, caseReason:this.value})
            .then(result => {
                const event = new ShowToastEvent({
                    title: 'Success',
                    message: 'Case successfully send to support team here is the record Id : '+result,
                    variant: 'success',
                    mode: 'dismissable'
                });
                //this.dispatchEvent(event);
                const closeclickedevt = new CustomEvent('closeclicked', {
                    detail: { result },
                });
                this.dispatchEvent(closeclickedevt);
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    message: 'Error while creating case ' +error,
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(event);
            });
    }
}