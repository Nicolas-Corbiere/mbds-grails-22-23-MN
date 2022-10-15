<%@ page import="com.mbds.grails.User" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <asset:stylesheet src="detailIllustration.css"/>
    </head>
    <body>
        <div id="show-illustration" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="detail-illustraion">
                <div class="illustration">
                        <asset:image class="img-illustration" src="${illustration.filename}" alt="illustration"/>
                </div>
                </br>
                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <sec:ifNotLoggedIn>
                            <div class="login">
                                <p>Vous êtes l'auteur de cette annonce et vous voulez la modifier ? </p>
                                <a href="/login/auth">Connectez-vous</a>
                            </div>
                        </sec:ifNotLoggedIn>
                    </sec:ifNotGranted>

                    <sec:ifLoggedIn>

                        <g:if test="${String.valueOf(illustration.annonce.author.id)==String.valueOf(sec.loggedInUserInfo(field : 'id'))}">

                            <g:form resource="${this.illustration}" method="DELETE">
                                <fieldset class="buttons">
                                    <g:link class="edit" action="edit" resource="${this.illustration}"> <div class="edit-button"><p>Edit</p></div></g:link>
                                    <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                    <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link> </fieldset>
                            </g:form>

                        </g:if>
                    </sec:ifLoggedIn>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <g:form resource="${this.illustration}" method="DELETE">
                            <fieldset class="buttons">
                                <g:link class="edit" action="edit" resource="${this.illustration}"> <div class="edit-button"><p>Edit</p></div></g:link>
                                <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link>
                            </fieldset>
                        </g:form>

                    </sec:ifAnyGranted>
                </div>
            </div>


    </div>
    </body>
</html>
