package mbds_grails_22_23

import com.mbds.grails.Annonce
import com.mbds.grails.Illustration
import com.mbds.grails.Role
import com.mbds.grails.User
import com.mbds.grails.UserRole
import util.CategoryType
import util.RoleType

class BootStrap {

    def init = { servletContext ->
        def adminUserInstance = new User(username: "admin",password: "admin",role: RoleType.ROLE_ADMIN).save()
        def adminRole = new Role(authority: RoleType.ROLE_ADMIN).save()
        def modeUserInstance = new User(username: "modo",password: "modo",role: RoleType.ROLE_MODERATEUR).save()
        def moderateurRole = new Role (authority: RoleType.ROLE_MODERATEUR).save()
        UserRole.create(adminUserInstance, adminRole, true)
        UserRole.create(modeUserInstance, moderateurRole, true)
        int catNb = 0;
        // On boucle sur une liste de 5 prénoms
        ["Alice", "Bob", "Charly"].each {
            String username ->
                // On crée les utilisateurs associés
                def userInstance = new User(username: username, password: "pass")
                // Pour chaque utilisateur on boucle 5 fois
                (1..4).each {
                    Integer index ->
                        // Pour ajouter 5 annonces par utilisateur
                        def annonceInstance;
                        switch (catNb) {
                            case 0 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.IMMOBILIER)
                                catNb++
                                break
                            case 1 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.VEHICULE)
                                catNb++
                                break
                            case 2 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.VACANCES)
                                catNb++
                                break
                            case 3 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.EMPLOI)
                                catNb++
                                break
                            case 4 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.MODE)
                                catNb++
                                break
                            case 5 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.MAISON)
                                catNb++
                                break
                            case 6 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.MULTIMEDIA)
                                catNb++
                                break
                            case 7 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.LOISIRS)
                                catNb++
                                break
                            case 8 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.MATERIEL_PROFESSIONEL)
                                catNb++
                                break
                            case 9 :
                                annonceInstance = new Annonce(title: username + " " + index, description: "Description de l'annonce", price: 10 * index,
                                        active: Boolean.TRUE,category: CategoryType.AUTRES)
                                catNb=0
                                break
                        }
                        (1..3).each {
                            // Et enfin 5 illustrations par annonce
                            if(catNb == 2) {
                                String filname = "impala" + it+".jpeg"
                                annonceInstance.addToIllustrations(new Illustration(filename: filname))
                            }
                            else {
                                annonceInstance.addToIllustrations(new Illustration(filename: "grails.svg"))
                            }
                        }
                        // On associe l'annonce créée à l'utilisateur
                        userInstance.addToAnnonces(annonceInstance)
                        // Et on sauvegarde l'utilisateur qui va sauvegarder ses annonces qui sauvegarderont leurs illustrations
                        userInstance.save(flush: true, failOnError: true)
                }
        }
    }
    def destroy = {

    }
}
