<aura:application extends="force:slds">
    <!-- Create attribute to store lookup value as a sObject--> 
    <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
    <aura:attribute name="accountName" type="String" default=""/>
    <c:customLookup accountName="{!v.accountName}" objectAPIName="account" IconName="standard:account" selectedRecord="{!v.selectedLookUpRecord}" label="Account Name"/>
    <!--c:dataTableDemo/-->
    <lightning:button variant="brand" label="Submit" onclick="{! c.handleClick }" />
    <!-- here c: is org. default namespace prefix-->
</aura:application>