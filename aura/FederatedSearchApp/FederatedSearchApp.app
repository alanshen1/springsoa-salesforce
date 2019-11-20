<!--
 - Created by spring4 on 20-11-2019.
 -->

<aura:application extends="force:slds">
    <aura:attribute name="Ids" type="String" />
    <c:FederatedSearchDisplayLT Ids="{!v.Ids}"/>
</aura:application>