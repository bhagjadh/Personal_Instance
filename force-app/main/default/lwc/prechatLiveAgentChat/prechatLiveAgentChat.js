import BasePrechat from 'lightningsnapin/basePrechat';
import { api, track } from 'lwc';
import startChatLabel from '@salesforce/label/c.startChatLabel';


export default class Prechat extends BasePrechat {
    @api prechatFields;
    @api backgroundImgURL;
    @track fields;
    @track namelist;
    startChatLabel;

    /**
     * Set the button label and prepare the prechat fields to be shown in the form.
     */
    connectedCallback() {
        this.startChatLabel = startChatLabel;
        this.fields = this.prechatFields.map(field => {
            const { label, name, value, required, maxLength } = field;
            console.log('prechatFields:-'+JSON.stringify(this.prechatFields));
            return { label, value, name, required, maxLength };
        });
        this.namelist = this.fields.map(field => field.name);
    }

    /**
     * Focus on the first input after this component renders.
     */
    renderedCallback() {
        this.template.querySelector("lightning-input").focus();
    }

    /**
     * On clicking the 'Start Chatting' button, send a chat request.
     */
    handleStartChat() {
        console.log('check1');
        this.template.querySelectorAll("lightning-input").forEach(input => {
            this.fields[this.namelist.indexOf(input.name)].value = input.value;
        });
        if (this.validateFields(this.fields).valid) {
            console.log('check2');
            this.startChat(this.fields);
        } else {
            console.log('check3');
            // Error handling if fields do not pass validation.
        }
    }
}