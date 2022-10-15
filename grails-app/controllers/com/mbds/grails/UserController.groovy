package com.mbds.grails

import grails.validation.ValidationException
import util.MethodeType
import util.RoleType

import static org.springframework.http.HttpStatus.*

class UserController {

    UserService userService
    AuthorisationService authorisationService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    boolean isAuthorize(String methode,User user) {
        return authorisationService.isAuthorizeUser(params,user,methode)
    }



    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond userService.list(params), model:[userCount: userService.count()]
    }

    def show(Long id) {
        User user = userService.get(id)
        if(authorisationService.isUserExit()) {
            if (isAuthorize(MethodeType.GET,user)) {
                respond userService.get(id)
            } else {
                forbidden()
            }
        }
        else {
            loginPage()
        }
    }

    def create() {
        respond new User(params)
    }

    def update(User user) {
        if (user == null) {
            notFound()
            return
        }

        try {
            if(authorisationService.isUserExit()) {
                if(isAuthorize(MethodeType.UPDATE,user)) {
                    if(user.role != RoleType.ROLE_ADMIN && user.role != RoleType.ROLE_CLIENT && user.role != RoleType.ROLE_MODERATEUR) {
                        user.setRole(RoleType.ROLE_CLIENT)
                    }
                    userService.save(user)
                    if(userService.getUserRole(user, user.role) != null) {
                        UserRole.create(user, userService.getRoleByName(user.role as String),true)
                    }
                    request.withFormat {
                        form multipartForm {
                            flash.message = message(code: 'default.updated.message', args: [message(code: 'user.label', default: 'User'), user.id])
                            redirect user
                        }
                        '*' { respond user, [status: OK] }
                    }
                }
                else {
                    userService.resetOldRole(user)
                    forbidden()
                }
            }
            else {
                loginPage()
            }
        } catch (ValidationException e) {
            respond user.errors, view:'edit'
            return
        }
    }

    def save(User user) {
        if (!isAuthorize(MethodeType.CREATE,user)) {
            forbidden()
        }
        if (user == null) {
            notFound()
            return
        }
        try {
            if(user.role != RoleType.ROLE_ADMIN && user.role != RoleType.ROLE_CLIENT && user.role != RoleType.ROLE_MODERATEUR) {
                user.setRole(RoleType.ROLE_CLIENT)
            }
            userService.save(user)
            UserRole.create(user, userService.getRoleByName(user.role),true)
            if(isAuthorize(MethodeType.GET,user)) {
                request.withFormat {
                    form multipartForm {
                        flash.message = message(code: 'default.created.message', args: [message(code: 'user.label', default: 'User'), user.id])
                        redirect user
                    }
                    '*' { respond user, [status: CREATED] }
                }
            }
            else {
                if(user.role != RoleType.ROLE_CLIENT) {
                    forbidden()
                }
                else {
                    if(user.role != RoleType.ROLE_ADMIN && user.role != RoleType.ROLE_CLIENT && user.role != RoleType.ROLE_MODERATEUR) {
                        user.setRole(RoleType.ROLE_CLIENT)
                    }
                    userService.save(user)
                    UserRole.create(user, userService.getRoleByName(user.role),true)
                    loginPage()
                }
            }
        } catch (ValidationException e) {
            respond user.errors, view:'create'
            return
        }
    }

    def edit(Long id) {
        respond userService.get(id)
    }

    def delete(Long id) {
        User user = userService.get(id);
        if (!authorisationService.isUserExit()) {
            loginPage()
        }
        if (!isAuthorize(MethodeType.DELETE, user)) {
            forbidden()
        }
        if (id == null) {
            notFound()
            return
        }
        userService.delete(id)
        if (authorisationService.getUserLogged().getId() == null) {
            session.invalidate()
            redirect action: 'index', controller: 'logout'
        } else {
            request.withFormat {
                form multipartForm {
                    flash.message = message(code: 'default.deleted.message', args: [message(code: 'user.label', default: 'User'), id])
                    redirect action: "index", method: "GET"
                }
                '*' { render status: NO_CONTENT }
            }
        }
    }

    protected void loginPage() {
        redirect action: 'auth', controller: 'login'
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    protected void forbidden() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.forbiden', args: [message(code: 'user.label', default: 'User'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: FORBIDDEN }
        }
    }
}
