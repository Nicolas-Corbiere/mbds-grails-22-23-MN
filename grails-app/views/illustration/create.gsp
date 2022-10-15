<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
    <asset:stylesheet src="modificationIllustration.css"/>
</head>

<body>

<div id="create-illustration" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>

    <sec:ifNotGranted roles="ROLE_ADMIN">
        <sec:ifNotLoggedIn>
            <div class="login">
                <p>Vous voulez déposer une annonce ?</p>
                <a href="/login/auth">Connectez-vous</a>
            </div>
        </sec:ifNotLoggedIn>
    </sec:ifNotGranted>
    <sec:ifLoggedIn>
        <div class="formulaire-illustration">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.illustration}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${this.illustration}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form class="form-illustration-to-create" resource="${this.illustration}" method="POST"  enctype="multipart/form-data">
                <h2>Formulaire de création d'illustration:</h2>
                <fieldset class="form">
                    <p>
                        <label for="filename">Sélectionner une illustration*:</label>
                        <input type="file" class="text_" id="filename" name="filename" accept="image/png, image/jpeg, image/svg"/>
                    </p>
                    <p>

                         <label for="annonce">Annonce*:</label>
                         <input  type="text" class="text_" name="annonce" id="annonce" value="${this.illustration.annonce}">${this.illustration.annonce}</>
                     </p>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </fieldset>
            </g:form>
        </div>
    </sec:ifLoggedIn>

</div>
<sec:ifLoggedIn><h3 class="logout"><asset:image class="icon-logout" src="logout.png" alt="logout"/><g:link
        controller="logout">Logout</g:link></h3></sec:ifLoggedIn>


</body>
</html>
