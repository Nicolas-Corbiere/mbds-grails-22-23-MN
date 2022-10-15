<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
        <asset:stylesheet src="listeUtilisateurs.css"/>
    </head>
    <body>
    <div class="header-list-user">
        <h1>Liste des utilisateurs</h1>
        <div class="create-user"><a href="/user/create">Creer un nouvel utilisateur</a></div>
    </div>
        <div id="list-user" class="content scaffold-list" role="main">

            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <g:each in="${userList}" var="user">
                <a href="/user/show/${user.id}">
                    <div class="item-c-content">
                        <h2> <asset:image class="img-user" src="user2.png" alt="user"/>Utilisateur: ${user?.username}, ID : ${user?.id}</h2>
                        <div class="mdp">
                            <h3>Mot de passe:</h3> <p>${user?.password}</p>
                        </div>
                        <div class="user-activite">
                            <p>
                                <h3>Mot de passe expirer ?:</h3>
                                <g:if test="${user?.passwordExpired==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                                <g:if test="${user?.passwordExpired==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                            </p>
                            <p>
                                <h3>Compte bloqué ?: </h3>
                                <g:if test="${user?.accountLocked==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                                <g:if test="${user?.accountLocked==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                            </p>
                            <p>
                                <h3>Compte expiré ?:</h3>
                                <g:if test="${user?.accountExpired==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                                <g:if test="${user?.accountExpired==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                            </p>
                            <p>
                                <h3>Actif ?:</h3>
                                <g:if test="${user?.enabled==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                                <g:if test="${user?.enabled==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                            </p>
                        </div>
                        <h3 class="title-annonce">Annonces: </h3>
                        <div class="user-annonce">

                        <g:each in="${user?.annonces}" var="annonce">
                            <h3>ID ${annonce?.id} :</h3><p>${annonce?.title}</p>
                        </g:each>
                        </div>
                    </div>
                </a>

            </g:each>


        </div>
    <div class="pagination">
        <g:paginate total="${userCount ?: 0}" />
    </div>
    </body>
</html>