<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <asset:stylesheet src="modificationUser.css"/>
</head>
<body>

<div id="edit-user" class="content scaffold-edit" role="main">
    <h1>Modification de l'utilisateur : ${this.user.username}</h1>
    <div class="edition-user">
        <sec:ifLoggedIn>
            <div class="formulaire-user">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.user}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.user}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form class="form-user-to-update" resource="${this.user}" method="PUT">
                    <g:hiddenField name="version" value="${this.user?.version}" />
                    <h2>Edition du Compte utilisateur: </h2>
                    <fieldset class="form">
                        <p>
                            <label for="username">Username*:</label>
                            <input type="text" class="text_" name="username" value="${this.user.username}" />
                                </p>
                    <p>
                        <label for="password">Password*:</label>
                        <input type="password" class="text_" name="password" value="${this.user.password}"/>
                    </p>
                    <p>
                        <label for="role">Role*:</label>
                        <p> Role Actuel : ${this.user.role}</p>
                        <sec:ifNotGranted roles="ROLE_MODERATEUR, ROLE_CLIENT">
                            <label for="role">Nouveau Role*:</label>
                            <select name="role" id="role">
                                <option value="">--Selectionner un role--</option>
                                <option value="ROLE_ADMIN">ADMIN</option>
                                <option value="ROLE_MODERATEUR">MODERATEUR</option>
                                <option value="ROLE_CLIENT">CLIENT</option>
                            </select>
                        </sec:ifNotGranted>
                    </p>
                    <p>
                        <label for="passwordExpired">Mot de passe Expire ?</label>
                        <g:if test="${this.user.passwordExpired==true}"><input type="checkbox" class="text_" name="passwordExpired" checked value="true"/></g:if>
                        <g:if test="${this.user.passwordExpired==false}"><input type="checkbox" class="text_" name="passwordExpired" /></g:if>
                    </p>
                    <p>
                        <label for="accountLocked">Compte bloque ?</label>
                        <g:if test="${this.user.accountLocked==true}"><input type="checkbox" class="text_" name="accountLocked" checked /></g:if>
                        <g:if test="${this.user.accountLocked==false}"><input type="checkbox" class="text_" name="accountLocked" /></g:if>
                    </p>
                    <p>
                        <label for="accountExpired">Compte expiré ?</label>
                        <g:if test="${this.user.accountExpired==true}"><input type="checkbox" class="text_" name="accountExpired" checked /></g:if>
                        <g:if test="${this.user.accountExpired==false}"><input type="checkbox" class="text_" name="accountExpired" /></g:if>
                    </p>
                    <p>
                        <label for="enabled">Actif ?</label>
                        <g:if test="${this.user.enabled==true}"><input type="checkbox" class="text_" name="enabled" checked /></g:if>
                        <g:if test="${this.user.enabled==false}"><input type="checkbox" class="text_" name="enabled" /></g:if>

                    </p>
                    <p>
                        <label for="annonces">Modifier ou supprimer  vos annonces*: </label>
                        <ul class="user-annonce">
                            <g:each in="${this.user.annonces}" var="annonce">
                                <li><a class="title-annonce" href="/annonce/show/${annonce.id}"><b>${annonce.title}</b> (click pour voir)</a>
                                    <div class="edit-user"><g:link class="edit" action="edit" resource="/annonce" id="${annonce.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link></div>
                                    <div class="edit-user"><g:link class="delete" action="delete" resource="/annonce" id="${annonce.id}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" ><g:message code="default.button.delete.label" default="Delete" /></g:link></div>
                                </li>
                            </g:each>
                        </ul>

                        <div class="create-annonce"><a href="/annonce/create?user.id=${user.id}">Creer une nouvelle annonce</a></div>
                    </p>
                    </fieldset>
                    <fieldset class="buttons">
                        <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                    </fieldset>
                </g:form>
            </div>
        </sec:ifLoggedIn>

    </div>
    <sec:ifLoggedIn> <h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/><g:link controller="logout">Logout</g:link></h3></sec:ifLoggedIn>
  </div>
</body>
</html>
