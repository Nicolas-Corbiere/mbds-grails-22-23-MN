package com.mbds.grails

import grails.validation.ValidationException
import util.MethodeType

import static org.springframework.http.HttpStatus.*

class IllustrationController {

    IllustrationService illustrationService
    AuthorisationService authorisationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    boolean isAuthorizeByAnnonceId(Long id,String methode) {
        return authorisationService.isAuthorizeAnnonce(id,methode)
    }

    boolean isAuthorize(Long id,String methode) {
        if(Illustration.get(id) != null) {
            Annonce annonce = Illustration.get(id).getAnnonce()
            return authorisationService.isAuthorizeAnnonce(annonce.getId(),methode)
        }
        else {
            return false
        }
    }

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond illustrationService.list(params), model:[illustrationCount: illustrationService.count()]
    }

    def show(Long id) {
        respond illustrationService.get(id)
    }

    def create() {
        if(authorisationService.isUserExit()) {
            respond new Illustration(params)
        }
        else {
            loginPage()
        }
    }

    def save(Illustration illustration) {
        if (illustration == null) {
            notFound()
            return
        }

        try {
            if(authorisationService.isUserExit()) {
                if (isAuthorizeByAnnonceId(illustration.getAnnonce().getId(),MethodeType.CREATE)) {
                    illustrationService.save(illustration)
                    request.withFormat {
                        form multipartForm {
                            flash.message = message(code: 'default.created.message', args: [message(code: 'illustration.label', default: 'Illustration'), illustration.id])
                            redirect illustration
                        }
                        '*' { respond illustration, [status: CREATED] }
                    }
                } else {
                    forbidden()
                }
            }
            else {
                loginPage()
            }
        } catch (ValidationException e) {
            respond illustration.errors, view:'create'
            return
        }


    }

    def edit(Long id) {
        if(authorisationService.isUserExit()) {
            if (isAuthorize(id, MethodeType.UPDATE)) {
                respond illustrationService.get(id)
            } else {
                forbidden()
            }
        }
        else {
            loginPage()
        }
    }

    def update(Illustration illustration) {
        if (illustration == null) {
            notFound()
            return
        }

        try {
            if(authorisationService.isUserExit()) {
                if (isAuthorizeByAnnonceId(illustration.getAnnonce().getId(),MethodeType.UPDATE)) {
                    illustrationService.save(illustration)
                    request.withFormat {
                        form multipartForm {
                            flash.message = message(code: 'default.updated.message', args: [message(code: 'illustration.label', default: 'Illustration'), illustration.id])
                            redirect illustration
                        }
                        '*' { respond illustration, [status: OK] }
                    }
                } else {
                    forbidden()
                }
            }
            else {
                loginPage()
            }

        } catch (ValidationException e) {
            respond illustration.errors, view:'edit'
            return
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        if(authorisationService.isUserExit()) {
            if (isAuthorize(id,MethodeType.DELETE)) {
                illustrationService.delete(id)
                request.withFormat {
                    form multipartForm {
                        flash.message = message(code: 'default.deleted.message', args: [message(code: 'illustration.label', default: 'Illustration'), id])
                        redirect action: "index", method: "GET"
                    }
                    '*' { render status: NO_CONTENT }
                }
            } else {
                forbidden()
            }
        }
        else {
            loginPage()
        }
    }

    protected void loginPage() {
        redirect action: 'auth', controller: 'login'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'illustration.label', default: 'Illustration'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    protected void forbidden() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.forbiden', args: [message(code: 'annonce.label', default: 'Illustration'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: FORBIDDEN }
        }
    }
}
