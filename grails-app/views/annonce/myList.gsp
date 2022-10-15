<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <asset:stylesheet src="listannonce.css"/>
</head>

<body>
    <h1>Liste de mes annonces:</h1>
    <div id="list-annonce" class="content-scaffold-list" role="main">

        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>

        <g:each in="${annonceList}" var="annonce">
                <a href="/annonce/show/${annonce.id}">
                    <div class="item-c-content">

                        <div  class="content-ad-annonce">
                            <!--conteneur de l'image de l'annonce -->
                            <div class="div-img-annonce">
                                <asset:image class="img-annonce" src="${annonce.illustrations[0].filename}" alt="annonce"/>
                            </div>
                            <!--conteneur des infos de l'annonce  -->
                            <div class="desc-ad">
                                <!--conteneur titre/description de l'annonce  -->
                                <div>
                                    <h2>${annonce?.title}</h2>
                                    <h3>Description: </h3>
                                    <p> ${annonce?.description}</p>
                                    <h3>Categorie: </h3>
                                    <p> ${annonce?.category}</p>
                                </div>
                                <div class="annonce-active">
                                    <h3>Active ? :</h3>
                                    <g:if test="${annonce?.active==true}"><asset:image class="check-true" src="checked.png" alt="check"/></g:if>
                                    <g:if test="${annonce?.active==false}"><asset:image class="check-false" src="remove.png" alt="remove"/></g:if>
                                </div>
                                <!--conteneur du temps et prix de l'annonce  -->
                                <div class="active-price">
                                    <p><b>Prix:</b> ${annonce?.price} € </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
        </g:each>
    </div>
    <div class="pagination">
        <g:paginate   total="${annonceCount ?: 0}" />
    </div>
    </br>
</body>
</html>