<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <asset:link rel="icon" href="lecoincoin.png" type="image/x-ico" />

    <asset:stylesheet src="index.css"/>
    <g:set var="entityName" value="${message(code: 'annonce.label', default: 'Annonce')}" />

    <g:layoutHead/>
</head>
<body>

<div class="navbar" role="navigation">
        <div class="container">
                <div class="navbar-header">
                    <a href="/#" class="navbar-brand" href="/#">
                         <asset:image src="lecoincoin.png" alt="lecoincoin Logo"/>
                    </a>
                </div>
                <div class="navbar-collapse" aria-expanded="false" style="height: 0.8px;">
                    <ul class="nav navbar-nav navbar-right">
                        <div class="navbarAnnonce">
                            <sec:ifNotGranted roles="ROLE_MODERATEUR">
                                <li class="navNewAnnonce">
                                    <a href="/annonce/create" class="newAnnonce" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="plus.png" alt="NewAnnonce"/> <p>Déposer une annonce<p> <span class="caret"></span></a>
                                </li>
                            </sec:ifNotGranted>
                            <li class="navSearch">
                                <a href="/annonce/index" class="search" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="search-interface-symbol.png" alt="Search"/><p>Toutes les annonces</p> <span class="caret"></span></a>
                            </li>
                        </div>
                        <div class="navbarperso">

                            <sec:ifLoggedIn>
                                <sec:ifNotGranted roles="ROLE_MODERATEUR">
                                    <li class="navperso">
                                        <a href="/annonce/myList" class="mes-annonces" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="comment.png" alt="annonces"/><p>Mes Annonces</p> <span class="caret"></span></a>
                                    </li>
                                </sec:ifNotGranted>
                                <sec:ifAnyGranted roles="ROLE_ADMIN,ROLE_MODERATEUR">
                                    <li class="navperso">
                                        <a href="/user/index" class="users" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="consumer.png" alt="users"/><p>Gestion des utilisateurs</p> <span class="caret"></span></a>
                                    </li>
                                </sec:ifAnyGranted>
                                <li class="navperso">
                                    <a href="/user/show/${String.valueOf(sec.loggedInUserInfo(field : 'id'))}" class="moncompte" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="user2.png" alt="account"/><p>Mon Compte</p> <span class="caret"></span></a>
                                </li>
                                <li class="navperso">
                                    <a href="/logout" class="logout-nav" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="logout.png" alt="MessageIcon"/><p>Logout</p> <span class="caret"></span></a>
                                </li>
                            </sec:ifLoggedIn>
                            <sec:ifNotLoggedIn>
                                <li class="navperso">
                                    <a href="/login/auth" class="login" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  <asset:image class="img-navbar" src="user.png" alt="UserConnexion"/> <p>Se connecter</p> <span class="caret"></span></a>
                                </li>
                            </sec:ifNotLoggedIn>

                        </div>
                    </ul>
                </div>

        </div>
        <div class="containerCategory">
            <div class="navbarCategory">
                <ul class="nav navbar-nav navbar-right">

                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Immobilier" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> Immobilier</a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Vehicules" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> Véhicules</a><span class="point">•</span>
                    </li>

                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Vacances" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> Vacances</a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Emploi" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> Emploi </a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Mode" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  Mode </a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Maison" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  Maison</a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Multimedia" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  Multimédia </a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Loisirs" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  Loisirs </a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Materiel-Professionnel" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> Matériel Professionnel </a><span class="point">•</span>
                    </li>
                    <li class="navCategories-Categorie">
                        <a href="/annonce/filterCategory/Autres" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">  Autres </a><span class="point"></span>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <g:layoutBody/>

    <div class="footer" role="contentinfo"></div>

    <div id="spinner" class="spinner" style="display:none;">
        <g:message code="spinner.alt" default="Loading&hellip;"/>
    </div>



</body>
</html>
