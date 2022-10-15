package com.mbds.grails

import grails.validation.ValidationException
import util.MethodeType

import static org.springframework.http.HttpStatus.*

class AnnonceController {

    AnnonceService annonceService
    AuthorisationService authorisationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    boolean isAuthorize(Long id,String methode) {
        if(authorisationService.isUserExit()) {
            return authorisationService.isAuthorizeAnnonce(id,methode)
        }
        else {
            loginPage()
        }
    }

    /**
     * @return return the list of annonce of the logged user
     */
    def myList(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        if(authorisationService.isUserExit()) {
            respond annonceService.listFilteredAuthor(authorisationService.getUserLogged()), model:[userCount: annonceService.count()]
        }
        else {
            loginPage()
        }
    }

    def filterCategory() {
        respond annonceService.listFilteredCategory(params.id), model:[userCount: annonceService.count()]
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond annonceService.list(params), model:[annonceCount: annonceService.count()]
    }

    def show(Long id) {
        respond annonceService.get(id)
    }

    def create() {
        if(authorisationService.isUserExit()) {
            respond new Annonce(params)
        }
        else {
            loginPage()
        }

    }
    def save() {
        Annonce annonce = new Annonce()
        annonce.title = params.title
        annonce.category = params.category
        annonce.description = params.description
        annonce.active = params.title
        annonce.price = Float.parseFloat(params.price)
        annonce.author = User.get(params.author.id)
        annonceService.creatIllustrationForAnnonce(request, annonce)
        if(!authorisationService.isUserExit()) {
            loginPage()
        }
        if (!isAuthorize(null, MethodeType.CREATE)) {
            forbidden()
        }
        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.save(annonce)
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.created.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                    redirect view: 'show',id: annonce.id
                }
                '*' { respond annonce, [status: CREATED] }
            }
        } catch (ValidationException e) {
            respond annonce.errors, view:'create'
            return
        }
    }

    def edit(Long id) {
        if(authorisationService.isUserExit()) {
            if (isAuthorize(id,MethodeType.UPDATE)) {
                respond annonceService.get(id)
            } else {
                forbidden()
            }
        }
        else {
            loginPage()
        }
    }

    def update() {
        if(!authorisationService.isUserExit()) {
            loginPage()
        }
        if (!isAuthorize(Long.parseLong(params.id),MethodeType.UPDATE)) {
            forbidden()
        }

        Annonce annonce = Annonce.get(params.id)
        annonce.title = params.title
        annonce.category = params.category
        annonce.description = params.description
        annonce.active = params.title
        annonce.price = Float.parseFloat(params.price)

        if (annonce == null) {
            notFound()
            return
        }

        try {
            annonceService.creatIllustrationForAnnonceUpdate(request, annonce)
            annonceService.removeIllustration(params, annonce)
            annonceService.save(annonce)
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.updated.message', args: [message(code: 'annonce.label', default: 'Annonce'), annonce.id])
                    redirect annonce
                }
                '*' { respond annonce, [status: OK] }
            }
        } catch (ValidationException e) {
            respond annonce.errors, view:'edit'
            return
        }
    }

    def delete(Long id) {
        if(!authorisationService.isUserExit()) {
            loginPage()
        }
        if (!isAuthorize(id,MethodeType.DELETE)) {
            forbidden()
        }
        if (id == null) {
            notFound()
            return
        }
        annonceService.delete(id)
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'annonce.label', default: 'Annonce'), id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }

    protected void loginPage() {
        redirect action: 'auth', controller: 'login'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    protected void forbidden() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.forbiden', args: [message(code: 'annonce.label', default: 'Annonce'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: FORBIDDEN }
        }
    }
}
