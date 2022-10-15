<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:stylesheet src="listllustration.css"/>
    </head>
    <body>
    <h1><g:message code="default.list.label" args="[entityName]" /></h1>
        <div id="list-illustration" class="content scaffold-list" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
                <g:each in="${illustrationList}" var="illustration">
                        <a href="/illustration/show/${illustration.id}">
                            <div class="item-c-content">


                                <div  class="content-ad-annonce">
                                    <h2>Annonce : ${illustration?.annonce.title}</h2>
                                    <div class="div-img-annonce">
                                        <asset:image class="img-annonce" src="${illustration.filename}" alt="illustration"/>
                                    </div>
                                </div>
                            </div>
                        </a>

                </g:each>

        </div>
    <div class="pagination">
        <g:paginate total="${illustrationCount ?: 0}" />
    </div>
    </body>
</html>