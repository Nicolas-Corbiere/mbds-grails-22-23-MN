<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <asset:stylesheet src="createUser.css"/>
</head>
<body>

<div id="create-user" class="content scaffold-create" role="main">
    <h1>Creer un utilisateur</h1>
    <div class="creation-user">
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

        <g:form resource="${this.user}" method="POST">
            <h2>Formulaire de création de compte utilisateur: </h2>
            <fieldset class="form">
                <p>
                    <label for="username">Username*:</label>
                    <input type="text" class="text_" name="username" id="username"/>
                </p>
                <p>
                    <label for="password">Password*:</label>
                    <input type="password" class="text_" name="password" id="password"/>
                </p>
                <p>
                    <sec:ifNotGranted roles="ROLE_MODERATEUR, ROLE_CLIENT">
                        <label for="role">Role*:</label>
                        <select name="role" id="role">
                            <option value="">--Selectionner un role--</option>
                            <option value="ROLE_ADMIN">ADMIN</option>
                            <option value="ROLE_MODERATEUR">MODERATEUR</option>
                            <option value="ROLE_CLIENT">CLIENT</option>
                        </select>
                    </sec:ifNotGranted>
                </p>
                <p class="hidden-fields">
                    <label for="passwordExpired">Annonce active ?</label>
                    <input type="checkbox" class="text_" name="passwordExpired" id="passwordExpired" />
                </p>
                <p class="hidden-fields">
                    <label for="accountLocked">Annonce active ?</label>
                    <input type="checkbox" class="text_" name="accountLocked" id="accountLocked" />
                </p>
                <p class="hidden-fields">
                    <label for="accountExpired">Annonce active ?</label>
                    <input type="checkbox" class="text_" name="accountExpired" id="accountExpired"/>
                </p>
                <p class="hidden-fields">
                    <label for="enabled">enabled ?</label>
                    <input type="checkbox" class="text_" name="enable" id="enabled" checked value="true"/>
                </p>
                <p class="hidden-fields">
                    <label for="annonces">Annonces :</label>
                    <a href="/annonce/create?user.id=${user.id}">Add Annonce</a>
                </p>

            </fieldset>
            <fieldset class="buttons">
                <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
            </fieldset>
        </g:form>

</div>
</div>
</body>
</html>
