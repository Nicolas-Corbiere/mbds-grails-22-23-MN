package com.mbds.grails

import grails.plugin.springsecurity.annotation.Secured
import util.RoleType
import util.MethodeType

@Secured(RoleType.PERMIT_ALL)
class ApiController {

    AuthorisationService authorisationService
    ApiService apiService

    /**
     * Singleton
     * Gestion des points d'entr?e : GET / PUT / PATCH / DELETE
     */
    def annonce() {
        // On v?rifie qu'un ID ait bien ?t? fourni
        if (!params.id)
            return response.status = 400
        // On v?rifie que l'id corresponde bien ? une instance existante
        def annonceInstance = Annonce.get(params.id)
        if (!annonceInstance)
            return response.status = 404
        switch (request.getMethod()) {
            case "GET":
                render apiService.renderThis(request.getHeader("Accept"), annonceInstance)
                break;
            case "PUT":
                //modification total
                if(authorisationService.isAuthorizeAnnonce(annonceInstance.getId(),MethodeType.UPDATE)) {
                    if (apiService.isAllParmsPresentAnnonce(request.JSON)) {
                        apiService.fullyUpdateAnnonce(annonceInstance, request.JSON);
                        render(status: 200, text: "Annonce fully updated")
                    } else {
                        render(status: 400, text: "Parameter is missing, please put those filds : title - description - price - active - category")
                    }
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            case "PATCH":
                //modification partiel
                if(authorisationService.isAuthorizeAnnonce(annonceInstance.getId(),MethodeType.UPDATE)) {
                    if (apiService.isParmsPresentAnnonce(request.JSON)) {
                        apiService.partialUpdateAnnonce(annonceInstance, request.JSON)
                        render(status: 200, text: "Annonce partialy updated")
                    } else {
                        render(status: 400, text: "Parameter is missing, please put one of those filds : title - description - price - active - category")
                    }
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            case "DELETE":
                if(authorisationService.isAuthorizeAnnonce(annonceInstance.getId(),MethodeType.DELETE)) {
                    apiService.deleteAnnonce(annonceInstance)
                    render(status: 200, text: "Annonce has been removed")
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            default:
                return response.status = 405
                break
        }
        return response.status = 406
    }

    /**
     * Collection
     * POST / GET
     */
    def annonces() {
        switch (request.getMethod()) {
            case "GET":
                render apiService.renderThis(request.getHeader("Accept"), Annonce.list())
                break
            case "POST":
                if (apiService.isAllParmsPresentAnnonceWithIllustration(request.JSON)) {
                    if(authorisationService.isAuthorizeAnnonce(null,MethodeType.CREATE)) {
                        Annonce annonce;
                        if(authorisationService.getUserLogged().getRole().equals(RoleType.ROLE_ADMIN)) {
                            annonce = apiService.createAnnonceAsAdmin(request.JSON)
                        }
                        else {
                            annonce = apiService.createAnnonce(request.JSON)
                        }
                        render(status: 200, text: "Annonce created " + annonce)
                    } else {
                        render(status: 403, text: "You don't have the authorisation required")
                    }
                }
                else {
                    render(status: 400, text: "Parameter is missing, please put one of those filds : title - description - price - active - category - illustration")
                }
                break
        }
        return response.status = 406
    }

    /**
     * Singleton
     * Gestion des points d'entr?e : GET / PUT / PATCH / DELETE
     */
    def user() {
        // On verifie qu'un ID ait bien ete fourni
        if (!params.id)
            return response.status = 400
        // On verifie que l'id corresponde bien a une instance existante
        def userInstance = User.get(params.id)
        if (!userInstance)
            return response.status = 404
        switch (request.getMethod()) {
            case "GET":
                if(authorisationService.isAuthorizeUser(request.JSON,userInstance,MethodeType.GET)) {
                    render apiService.renderThis(request.getHeader("Accept"), userInstance)
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            case "PUT":
                //modification total
                if(authorisationService.isAuthorizeUser(params,userInstance,MethodeType.UPDATE)) {
                    if (apiService.isAllParmsPresentUser(request.JSON)) {
                        apiService.fullyUpdateUser(userInstance, request.JSON);
                        render(status: 200, text: "User fully updated")
                    } else {
                        render(status: 400, text: "Parameter is missing, please put those filds : username - password - role")
                    }
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            case "PATCH":
                //modification partiel
                if(authorisationService.isAuthorizeUser(params,userInstance,MethodeType.UPDATE)) {
                    if (apiService.isParmsPresentUser(request.JSON)) {
                        apiService.partialUpdateUser(userInstance, request.JSON)
                        render(status: 200, text: "User partialy updated")
                    } else {
                        render(status: 400, text: "Parameter is missing, please put one of those filds : username - password - role")
                    }
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            case "DELETE":
                if(authorisationService.isAuthorizeUser(params,userInstance,MethodeType.DELETE)) {
                    apiService.deleteUser(userInstance)
                    render(status: 200, text: "User has been removed")
                }
                else {
                    render(status: 403, text: "You don't have the authorisation required")
                }
                break;
            default:
                return response.status = 405
                break;
        }
        return response.status = 406
    }

    /**
     * Collection
     * POST / GET
     */
    def users() {
        switch (request.getMethod()) {
            case "GET":
                render apiService.renderThis(request.getHeader("Accept"), User.list())
                break
            case "POST":
                if (apiService.isAllParmsPresentUser(request.JSON)) {
                    if(authorisationService.isAuthorizeUser(request.JSON,null,MethodeType.CREATE)) {
                        User user = apiService.createUserWithAdminRight(request.JSON);
                        render(status: 200, text: "User creted as " + request.JSON.role + " " + user)
                    }
                    else {
                        render(status: 403, text: "You don't have the authorisation required, Only a admin can create a usr with a specific role")
                    }
                } else if(apiService.isAllParmsPresentUserNoRole(request.JSON)) {
                    if(authorisationService.isAuthorizeUser(request.JSON,null,MethodeType.CREATE)) {
                        User user =  apiService.creatUser(request.JSON);
                        render(status: 200, text: "User created as Client " + user)
                    }
                }
                else {
                    render(status: 400, text: "Parameter is missing, please put those filds : username - password - role")
                }
                break
        }
        return response.status = 406
    }

}
