[{capture append="oxidBlock_pageBody"}]
    [{if $oView->showRDFa()}]
        [{include file="rdfa/rdfa.tpl"}]
    [{/if}]

    [{block name="layout_header"}]
        [{include file="layout/header.tpl"}]
    [{/block}]

    [{assign var="blFullwidth" value=$oViewConf->getViewThemeParam('blFullwidthLayout')}]

    <div id="wrapper" [{if $sidebar}]class="sidebar[{$sidebar}]"[{/if}]>

        <div class="[{if $blFullwidth}]container[{else}]container-fluid[{/if}]">

            <div class="underdog">

                <div class="row">

                    [{if $oView->getClassName()=='start' && $oView->getBanners()|@count > 0}]
                        [{include file="widget/promoslider.tpl"}]
                    [{/if}]

                </div>

                <div class="content-box">

                    [{*if $oView->getClassName() != "start" && !$blHideBreadcrumb}]
                        [{block name="layout_breadcrumb"}]
                            [{include file="widget/breadcrumb.tpl"}]
                        [{/block}]
                    [{/if*}]

                    [{$smarty.capture.loginErrors}]

                    <div class="row">

                        [{*if $oxcmp_user}]
                            <div class="col-xs-12 col-md-2 [{$oView->getClassName()}]">
                                <div id="sidebar_left">
                                    [{include file="layout/sidebar_left.tpl"}]
                                </div>
                            </div>
                        [{/if*}]

                        <div class="col-xs-12 col-md-9">

                            <div id="content">
                                [{block name="content_main"}]
                                    [{include file="message/errors.tpl"}]

                                    [{foreach from=$oxidBlock_content item="_block"}]
                                        [{$_block}]
                                    [{/foreach}]
                                [{/block}]
                            </div>

                        </div>

                        [{if $sidebar && $sidebar == "Right"}]
                            <div class="col-xs-12 col-md-3 [{$oView->getClassName()}]">
                                <div id="sidebar">

                                    [{if $findologic}]
                                        [{include file="page/search/findologic_filter.tpl"}]
                                    [{/if}]

                                    [{if $oxcmp_user}]
                                        [{include file="layout/sidebar_user.tpl"}]
                                    [{/if}]

                                    [{include file="layout/sidebar.tpl"}]

                                    [{if $oxcmp_user}]
                                        [{include file="layout/sidebar_newsletter.tpl"}]
                                    [{/if}]

                                </div>
                            </div>
                        [{/if}]
                    </div>

                </div>

            </div>

        </div>

    </div>

    [{include file="layout/footer.tpl"}]

    [{block name="layout_init_social"}]
    [{/block}]

    <i class="fa fa-chevron-circle-up icon-4x" id="jumptotop"></i>
[{/capture}]
[{include file="layout/base.tpl"}]
