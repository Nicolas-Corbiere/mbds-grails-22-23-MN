<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.create.label" args="[entityName]" /></title>
    <asset:stylesheet src="creationAnnonce.css"/>
</head>
<body>
<div id="create-annonce" class="content scaffold-create" role="main">
    <h1>Créer une Annonce</h1>
    <div class="creation-annonce">
        <sec:ifNotGranted roles="ROLE_MODERATEUR">
            <sec:ifNotLoggedIn>
                <div class="login">
                    <p>Vous voulez déposer une annonce ? </p>
                    <a href="/login/auth">Connectez-vous</a>
                </div>
            </sec:ifNotLoggedIn>

        <sec:ifLoggedIn>
            <div class="formulaire-annonce">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.annonce}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.annonce}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form resource="${this.annonce}" method="POST" enctype="multipart/form-data">
                    <h2>Formulaire de création d'Annonce: </h2>
                    <fieldset class="form">
                        <p>
                            <label for="title">Title*:</label>
                            <input type="text" class="text_" name="title" />
                        </p>
                        <p>
                            <label for="description">Description*:</label>
                            <input type="text" class="text_" name="description" />
                        </p>
                        <p>
                            <label for="category">Categorie*:</label>
                            <select name="category" id="category">
                                <option value="">--Selectionner une categorie--</option>
                                <option value="Immobilier">Immobilier</option>
                                <option value="Vehicules">Véhicules</option>
                                <option value="Vacances">Vacances</option>
                                <option value="Emploi">Emploi</option>
                                <option value="Mode">Mode</option>
                                <option value="Maison">Maison</option>
                                <option value="Multimedia">Multimédia</option>
                                <option value="Loisirs">Loisirs</option>
                                <option value="Materiel-Professionnel">Matériel Professionnel</option>
                                <option value="Autres">Autres</option>
                            </select>
                        </p>
                        <p>
                            <label for="price">Prix*:</label>
                            <input type="text" class="text_" name="price" />
                        </p>

                        <p>
                            <label for="active">Annonce active ?</label>
                            <input type="checkbox" class="text_" name="active" value="true" />

                        </p>
                        <p>
                            <label for="illustrationz">Sélectionner vos illustrations*: </label>
                            <input type="file" class="text_" name="illustrationz"  multiple accept="image/png, image/jpeg, image/svg"/>
                        </p>
                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <p class="author-annonce">
                            <label for="author">Auteur de l'annonce*</label>
                            <input  type="text" class="text_" name="author.id" id="author" value="${String.valueOf(sec.loggedInUserInfo(field : 'id'))}">
                        </p>
                    </sec:ifNotGranted>
                        <sec:ifAnyGranted roles="ROLE_ADMIN">
                            <p >
                                <label for="author">Auteur de l'annonce*</label>
                                <p style="font-style: italic">Changer l'id si vous n'etes pas l'autheur de l'annonce</p>
                                <input  type="text" class="text_" name="author.id" value="${String.valueOf(sec.loggedInUserInfo(field : 'id'))}">
                            </p>
                        </sec:ifAnyGranted>
                    </fieldset>
                    <fieldset class="buttons">
                        <g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                    </fieldset>
                </g:form>
            </div>
        </sec:ifLoggedIn>
    </div>
    <sec:ifLoggedIn> <h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/><g:link controller="logout">Logout</g:link></h3></sec:ifLoggedIn>
        </sec:ifNotGranted>
</div>
</body>
</html>
