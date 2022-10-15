<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
        <asset:stylesheet src="listeUtilisateurs.css"/>
    </head>
    <body>
    <h1>Utilisateur: ${this.user.username} d'id: ${this.user.id}</h1>
        <div id="show-user" class="content scaffold-show" role="main">
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <div class="item-c-content">
                <h2> <asset:image class="img-user" src="user2.png" alt="user"/>Utilisateur: ${user?.username} </h2>
                <div class="mdp">
                    <h3>Mot de passe:</h3> <p>${user?.password}</p>
                </div>
                <div class="user-activite">
                    <p>
                    <h3>Mot de passe expirer ?:</h3>
                    <g:if test="${user.passwordExpired==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                    <g:if test="${user.passwordExpired==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                </p>
                    <p>
                    <h3>Compte bloqué ?: </h3>
                    <g:if test="${user.accountLocked==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                    <g:if test="${user.accountLocked==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                </p>
                    <p>
                    <h3>Compte expiré ?:</h3>
                    <g:if test="${user.accountExpired==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                    <g:if test="${user.accountExpired==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                </p>
                    <p>
                    <h3>Actif ?:</h3>
                    <g:if test="${user.enabled==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                    <g:if test="${user.enabled==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                </p>
                </div>
                <h3 class="title-annonce">Annonces: </h3>
                <div class="user-annonce">

                    <g:each in="${user.annonces}" var="annonce">
                        <h3>ID ${annonce.id} :</h3><p>${annonce.title}</p>
                    </g:each>
                </div>
            </div>
            <sec:ifNotGranted roles="ROLE_ADMIN">
                <sec:ifLoggedIn>
                    <g:if test="${String.valueOf(user.id)==String.valueOf(sec.loggedInUserInfo(field : 'id'))}">

                        <g:form resource="${this.user}" method="DELETE">
                            <fieldset class="buttons">
                                <g:link class="edit" action="edit" resource="${this.user}"> <div class="edit-button"><p>Edit</p></div></g:link>
                                <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link></fieldset>
                        </g:form>

                    </g:if>
                </sec:ifLoggedIn>
            </sec:ifNotGranted>
            <sec:ifAnyGranted roles="ROLE_ADMIN">
                <g:form resource="${this.user}" method="DELETE">
                    <fieldset class="buttons">
                        <g:link class="edit" action="edit" resource="${this.user}"> <div class="edit-button"><p>Edit</p></div></g:link>
                        <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link>
                    </fieldset>
                </g:form>
            </sec:ifAnyGranted>

        </div>
<script>

</script>
    </body>
</html>
