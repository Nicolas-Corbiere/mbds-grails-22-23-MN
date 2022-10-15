<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'illustration.label', default: 'Illustration')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <asset:stylesheet src="modificationIllustration.css"/>
    </head>
    <body>
        <div id="edit-illustration" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <div class="edition-illustration">
                <sec:ifLoggedIn>
                    <div class="formulaire-illustration">
                        <g:if test="${flash.message}">
                            <div class="message" role="status">${flash.message}</div>
                        </g:if>
                        <g:hasErrors bean="${this.illustration}">
                            <ul class="errors" role="alert">
                                <g:eachError bean="${this.illustration}" var="error">
                                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                                </g:eachError>
                            </ul>
                        </g:hasErrors>
                        <g:form class="form-illustration-to-update" resource="${this.illustration}" method="PUT"  enctype="multipart/form-data">
                            <g:hiddenField name="version" value="${this.annonce?.version}" />
                            <h2>Edition de votre illustration: </h2>
                            <fieldset class="form">
                                <p>
                                    <label for="filename">Title*:</label>
                                    <input type="text" class="text_" name="filename" value="${this.illustration.filename}" />
                                        <span>Remplacer par :</span>
                                    <input type="file" class="text_" name="filename"  multiple accept="image/png, image/jpeg, image/svg"/>
                                </p>
                            <p class="annonce-illu">
                                <label for="annonce">Annonce*:</label>
                                <input  type="text" class="text_" name="annonce" id="annonce" value="${this.illustration.annonce}">${this.illustration.annonce}</input>
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
