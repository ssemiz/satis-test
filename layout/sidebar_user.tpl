[{block name="sidebar_user"}]
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-12 col-xs-12" style="padding-top:52px">

            <div class="panel panel-default">
                <div class="panel-heading">Adresse</div>
                <div class="panel-body">

                    <div><strong>Rechnungsadresse</strong></div>
                    [{if $oxcmp_user->oxuser__oxcompany->value}][{ $oxcmp_user->oxuser__oxcompany->value }]<br />[{/if}]
                    [{ $oxcmp_user->oxuser__oxstreet->value }] [{ $oxcmp_user->oxuser__oxstreetnr->value }]<br />
                    [{ $oxcmp_user->oxuser__oxzip->value }] [{ $oxcmp_user->oxuser__oxcity->value }]<br />
                    [{ $oxcmp_user->getUserCountry() }]<br />

                    <div class="text-right"><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_user"}]">ÄNDERN</a></div>


[{if $oxcmp_user->getUserAddresses()|@count > 0 }]<hr>
                    <div><strong>Lieferadresse</strong></div>

                    [{foreach from=$oxcmp_user->getUserAddresses() item=address}]
                    [{*if $address->selected*}]
                    <p>
                        [{if $address->oxaddress__oxcompany->value }][{ $address->oxaddress__oxcompany->value }]<br />[{/if}]
                        [{ $address->oxaddress__oxfname->value }] [{ $address->oxaddress__oxlname->value }]<br />
                        [{ $address->oxaddress__oxstreet->value }] [{ $address->oxaddress__oxstreetnr->value }]<br />
                        [{ $address->oxaddress__oxzip->value }] [{ $address->oxaddress__oxcity->value }]<br />
                        [{ $address->oxaddress__oxcountry->value }]<br />
                    </p>
                    [{*/if*}]
                    [{/foreach}]

                    <div class="text-right"><a href="[{oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=account_user"}]">ÄNDERN</a></div>
[{/if}]
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">Zahlungsart</div>
                <div class="panel-body">

                    [{if $dd_paymentlist}]

                    [{if $shop->cl == 'prosenio_account_payment' || $shop->cl == 'payment'}]
                    [{assign var="iPayError" value=$oView->getPaymentError()}]
                    [{/if}]

                    <div class="dd_left_adressen">
                        [{foreach key=sPaymentID from=$dd_paymentlist item=paymentmethod name=PaymentSelect}]

                        [{* $paymentmethod->oxpayments__oxdesc->value*}]

                        [{ if $dd_selected_payment == $paymentmethod->oxpayments__oxid->value}]
                        <p class="dd_font_bold">
                            [{ $paymentmethod->oxpayments__oxdesc->value}]
                        </p>
                        <p>
                            [{ $paymentmethod->oxpayments__oxlongdesc->value}]
                        </p>

                        [{ if $paymentmethod->oxpayments__oxid->value == "19fc4bff6a50aa1532d12e9e0dc9fd8b" }]

                        [{ if !$dynvalue.lsbankname }]
                        <p style="color: #ff0000;">
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">Bitte Bankname eintragen!</a>
                        </p>
                        [{ /if}]

                        [{ if !$dynvalue.lsblz && $iPayError != "162" }]
                        <p style="color: #ff0000;">
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">Bitte BIC eintragen!</a>
                        </p>
                        [{ /if}]

                        [{ if !$dynvalue.lsktonr && $iPayError != "161"}]
                        <p style="color: #ff0000;">
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">Bitte IBAN eintragen!</a>
                        </p>
                        [{ /if}]

                        [{ if !$dynvalue.lsktoinhaber }]
                        <p>
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">Bitte Kontoinhaber eintragen!</a>
                        </p>
                        [{ /if}]

                        [{ /if }]

                        [{if $iPayError == "161"}]
                        <p>
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">IBAN existiert nicht!</a>
                        </p>
                        [{/if}]

                        [{if $iPayError == "162"}]
                        <p>
                            <a style="color: #ff0000;" href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">BIC existiert nicht!</a>
                        </p>
                        [{/if}]

                        <div class="text-right">
                            <a href="[{ oxgetseourl ident=$oViewConf->getSelfLink()|cat:"cl=prosenio_account_payment" }]">ÄNDERN</a>
                        </div>
                        [{ /if}]
                        [{ /foreach }]
                    </div>
                    [{/if}]

                </div>
            </div>
            [{assign var="currency" value=$oView->getActCurrency()}]
            <div class="panel panel-default">
                <div class="panel-heading">Überblick</div>
                <div class="panel-body">
            Bestellungen in [{ $dd_jahr }]: [{ $dd_anz_bestellungen }]
                    <hr>
            Umsatz in [{ $dd_jahr }]: [{ $dd_umsatz }] [{ $currency->sign|strip_tags}]
                    <hr>
            Für Sie zuständig<br>
                    [{ oxmultilang ident="INC_RIGHT_BETREUER" }]<br>
                    <span class="icon-telefon"></span> [{ $oxcmp_shop->oxshops__oxtelefon->value }]
                </div>
            </div>
        </div>
    </div>
</div>
[{/block}]

