<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
    <asset:stylesheet src="modificationAnnonce.css"/>
</head>
<body>
<div id="edit-annonce" class="content scaffold-edit" role="main">
    <h1>Modification de votre Annonce: ${this.annonce.title}</h1>

    <div class="edition-annonce">
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
                <g:form class="form-annonce-to-update" resource="${this.annonce}" method="PUT"  enctype="multipart/form-data">
                    <g:hiddenField name="version" value="${this.annonce?.version}" />
                    <h2>Edition de votre Annonce: </h2>
                    <fieldset class="form">
                        <p>
                            <label for="title">Title*:</label>
                            <input type="text" class="text_" name="title" value="${this.annonce.title}" />
                        </p>
                    <p>
                        <label for="description">Description*:</label>
                        <textarea type="text" class="text_" name="description" >${this.annonce.description}</textarea>
                    </p>
                    <p>
                        <label for="category">Categorie actuelle:</label>
                        <p>${this.annonce.category}</p>
                        <label for="role">Nouvelle Categorie*:</label>
                        <select name="category" id="category">
                            <option value="${this.annonce.category}">${this.annonce.category}</option>
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
                        <input type="text" class="text_" name="price" value="${this.annonce.price}" />
                    </p>
                    <p>
                        <label for="active">Annonce active ?</label>
                        <g:if test="${this.annonce.active==true}"><input type="checkbox" class="text_" name="active" checked value="true"/></g:if>
                        <g:if test="${this.annonce.active==false}"><input type="checkbox" class="text_" name="active" /></g:if>
                    </p>
                    <p>
                        <label for="illustrationz">Sélectionner vos illustrations*: </label>
                        <input type="file" class="text_" name="illustrationz" multiple accept="image/png, image/jpeg, image/svg"/>
                    </p>
                    <ul class="illu-annonce">
                            <g:each in="${this.annonce.illustrations}" var="illu">
                                <li>
                                    <a href="/illustration/show/${illu.id}"><asset:image id="img-to-show${illu.filename}"  src="${illu.filename}" alt="annonce"/></a>
                                    <p style="margin-left: 20px; font-style: italic">Supprimer l'illustration ? : </p>
                                    <input type="checkbox" class="text_" name="${illu.id}-delete" value="true" />
                                </li>
                            </g:each>
                    </ul>

                    <sec:ifNotGranted roles="ROLE_ADMIN">
                        <p class="author-annonce">
                            <label for="author">Auteur de l'annonce*</label>
                            <input  type="text" class="text_" name="author.id" id="author" value="${String.valueOf(sec.loggedInUserInfo(field : 'id'))}">
                        </p>
                    </sec:ifNotGranted>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <p >
                            <label for="author">Auteur de l'annonce*</label>
                            <input  type="text" class="text_" name="author.id" value="${this.annonce.author.id}">
                        </p>
                    </sec:ifAnyGranted>
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
