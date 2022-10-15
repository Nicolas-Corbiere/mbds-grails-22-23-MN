<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.show.label" args="[entityName]" /></title>
    <asset:stylesheet src="detailannonce.css"/>

</head>

<body>


<div id="show-annonce" class="content scaffold-show" role="main">
    <h1>Détails de l'annonce: ${annonce.title}</h1>
    <div class="detail-annonce">
        <div class="cadre_diapo">
            <div class="interieur_diapo">
                <asset:image id="image-to-change" class="img-annonce" src="${annonce.illustrations[0].filename}" alt="annonce"/>
            </div>
            <ul class="navigation_diapo">
                <g:each in="${annonce.illustrations}" var="illu">
                    <li class="img-annonce">
                        <asset:image  onclick="switchImage(this.id)"  id="img-to-show${illu.filename}"  src="${illu.filename}" alt="annonce"/>
                    </li>
                </g:each>
            </ul>
        </div>



        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <div class="annonce">
            <div  class="content-ad-details">
                <!--conteneur des infos de l'annonce  -->
                <div class="desc-ad">
                    <!--conteneur titre/description de l'annonce  -->
                    <div>
                        <h3>Description</h3>
                        <p>${annonce.description} </p>
                        <h3>Categorie: </h3>
                        <p> ${annonce?.category}</p>
                    </div>
                    <!--conteneur du temps et prix de l'annonce  -->
                    <div class="active-price">
                        <p><b>Prix:</b> ${annonce.price} € </p>
                    </div>
                </br>
                    <div>
                        <h4>Auteur de l'annonce :</h4>
                        <p>${annonce.author.username}</p>
                    </div>
                </div>
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

                <g:if test="${String.valueOf(annonce.author.id)==String.valueOf(sec.loggedInUserInfo(field : 'id'))}">
                        <g:form resource="${this.annonce}" method="DELETE">
                        <fieldset class="buttons">
                            <g:link class="edit" action="edit" resource="${this.annonce}"> <div class="edit-button"><p>Edit</p></div></g:link>
                            <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                            <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link>
                        </fieldset>
                    </g:form>

                </g:if>
            </sec:ifLoggedIn>
            <sec:ifAnyGranted roles="ROLE_ADMIN">
                <g:form resource="${this.annonce}" method="DELETE">
                    <fieldset class="buttons">
                        <g:link class="edit" action="edit" resource="${this.annonce}"> <div class="edit-button"><p>Edit</p></div></g:link>
                        <input class="delete" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                        <g:link controller="logout"><h3 class="logout"><asset:image  class="icon-logout" src="logout.png" alt="logout"/>Logout</h3></g:link>
                    </fieldset>
                </g:form>

            </sec:ifAnyGranted>
        </div>
    </div>

</div>
<script>
    function switchImage(id){
        document.getElementById("image-to-change").src=document.getElementById(id).src;
    }
</script>
</body>

</html>
