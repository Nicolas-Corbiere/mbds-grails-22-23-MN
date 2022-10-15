package com.mbds.grails

import grails.gorm.transactions.Transactional
import grails.web.servlet.mvc.GrailsParameterMap
import util.MethodeType
import util.RoleType

@Transactional
class AuthorisationService {

    def springSecurityService
    public static final int indexAdmin = 0
    public static final int indexModerateur = 1

    /**
     * @param id of the user
     * @param methode is the action wanted (GET,CREATE,UPDATE,DELETE)
     * @return return if the current user is autorize to perform this action on the annonce selected (true in function of is role OR if he is the author)
     */
    boolean isAuthorizeUser(def parms,User user, String methode) {
        User userLoged = springSecurityService.getCurrentUser()
        if(isUserExit()) {
            if(methode.equals(MethodeType.UPDATE) && !String.valueOf(parms.role).equals(user.role)
                    || methode.equals(MethodeType.CREATE) && parms.role != null && !String.valueOf(parms.role).equals(RoleType.ROLE_CLIENT)) {
                boolean[] roles = checkRoles(userLoged)
                return roles[indexAdmin]
            } else {
                boolean[] roles = checkRoles(userLoged)
                return String.valueOf(userLoged.getId()) == String.valueOf(parms.id) || checkRoleRightByMethodeUser(roles[indexAdmin], roles[indexModerateur], methode)
            }
        }
        else {
            return false
        }
    }

    /**
     *
     * @param id of the annonce
     * @param methode is the action wanted (GET,CREATE,UPDATE,DELETE)
     * @return return if the current user is autorize to perform this action on the annonce selected (true in function of is role OR if he is the author)
     */
    boolean isAuthorizeAnnonce(Long id,String methode) {
        User user = springSecurityService.getCurrentUser()
        if(isUserExit()) {
            boolean[] roles = checkRoles(user)
            if(Annonce != null && Annonce.get(id) != null) {
                return Annonce.get(id).getAuthor().getId() == user.getId() || checkRoleRightByMethodeAnnonce(roles[indexAdmin],roles[indexModerateur],methode)
            }
            else {
                return checkRoleRightByMethodeAnnonce(roles[indexAdmin],roles[indexModerateur],methode)
            }
        }
        else return false
    }

    /**
     * @return check if the user exist
     */
    boolean isUserExit() {
        if(springSecurityService.getCurrentUser() == null) {
            return false
        }
        else {
            return true
        }
    }

    /**
     * @return return an array of boolean,
     * If roles[0] == true, th user is admin.
     * If roles[1] == true, th user is moderateur.
     */
    boolean[] checkRoles(User user) {
        boolean[] roles = [false,false]
        user.getAuthorities().forEach() {
            if(it.getAuthority().equals(RoleType.ROLE_ADMIN)) {
                roles[indexAdmin] = true
            } else if (it.getAuthority().equals(RoleType.ROLE_MODERATEUR)) {
                roles[indexModerateur] = true
            }
        }
        return roles
    }

    /**
     *
     * @param isAdmin
     * @param isModerator
     * @param methode methode is the action wanted (GET,CREATE,UPDATE,DELETE)
     * @return depending of his role, look if the user is authorise in function of the methode asked
     */
    boolean checkRoleRightByMethodeUser(boolean isAdmin,boolean isModerator, String methode) {
        if (methode.equals(MethodeType.GET) || methode.equals(MethodeType.UPDATE)) {
            if (isAdmin || isModerator) {
                return true
            } else {
                return false
            }
        } else if (methode.equals(MethodeType.CREATE)) {
            return true
        } else if (methode.equals(MethodeType.DELETE)) {
            if(isAdmin) {
                return true
            }
            else {
                return false
            }
        }
        else {
            System.err.println("The methode '" + methode + "' is unknow");
            return false;
        }
    }

    /**
     * @param isAdmin
     * @param isModerator
     * @param methode methode is the action wanted (GET,CREATE,UPDATE,DELETE)
     * @return depending of his role, look if the user is authorise in function of the methode asked
     */
    boolean checkRoleRightByMethodeAnnonce(boolean isAdmin,boolean isModerator, String methode) {
        boolean isClient = !isModerator && !isAdmin
        if (methode.equals(MethodeType.GET) || methode.equals(MethodeType.UPDATE)) {
            if (isAdmin || isModerator) {
                return true
            } else {
                return false
            }
        } else if (methode.equals(MethodeType.DELETE)) {
            if(isAdmin) {
                return true
            }
            else {
                return false
            }
        } else if(methode.equals(MethodeType.CREATE)) {
            if(isAdmin || isClient) {
                return true
            }
            else {
                return false
            }
        }
        else {
            System.err.println("The methode '" + methode + "' is unknow");
            return false;
        }
    }

    User getUserLogged() {
        return springSecurityService.getCurrentUser()
    }
}
