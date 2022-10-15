package com.mbds.grails

import grails.converters.JSON
import grails.converters.XML
import grails.gorm.transactions.Transactional
import grails.util.BuildSettings
import grails.web.servlet.mvc.GrailsParameterMap
import sun.misc.BASE64Decoder
import util.RoleType

import javax.imageio.ImageIO

@Transactional
class ApiService {

    AuthorisationService authorisationService

    def renderThis(String acceptHeader, Object object) {
        switch (acceptHeader.toLowerCase()) {
            case 'xml':
            case 'text/xml':
            case 'application/xml':
                return object as XML
                break;
            case 'json':
            case 'text/json':
            case 'application/json':
                return object as JSON
                break;
            default:
                return 406
        }
    }

    // -- Annonce

    boolean isAllParmsPresentAnnonce(def params) {
        return params.title && params.description && params.price && params.active && params.category
    }

    boolean isParmsPresentAnnonce(def params) {
        return params.title || params.description || params.price || params.active || params.category
    }

    boolean isAllParmsPresentAnnonceWithIllustration(def params) {
        return params.title && params.description && params.price && params.active && params.category && params.illustration
    }

    void fullyUpdateAnnonce(Annonce annonceInstance,def params) {
        float priceF =  params.price
        boolean activeR =  params.active
        // get the values
        String title = params.title
        String description = params.description
        Float price = priceF
        Boolean active = activeR
        String category = params.category
        // set the values
        annonceInstance.setTitle(title)
        annonceInstance.setDescription(description)
        annonceInstance.setPrice(price)
        annonceInstance.setActive(active)
        annonceInstance.setCategory(category)
        // update the annonce
        annonceInstance.save()
    }

    void partialUpdateAnnonce(Annonce annonceInstance,def params) {
        if(params.title) {
            String title = params.title
            annonceInstance.setTitle(title)
        }
        if(params.description) {
            String description = params.description
            annonceInstance.setDescription(description)
        }
        if(params.price) {
            Float price = Float.parseFloat(params.price)
            annonceInstance.setPrice(price)
        }
        if(params.active) {
            Boolean active = Boolean.parseBoolean(params.active)
            annonceInstance.setActive(active)
        }
        if(params.category) {
            String category = params.category
            annonceInstance.setCategory(category)
        }
        // update the annonce
        annonceInstance.save()
    }

    def deleteAnnonce(Annonce annonceInstance) {
        annonceInstance.delete()
    }

    // -- Annonces

    Annonce createAnnonceAsAdmin(def params) {
        final String immageDir = "\\grails-app\\assets\\images\\";
        float priceF = params.price
        boolean activeB = params.active
        String title = params.title
        String description = params.description
        Float price = priceF
        Boolean active = activeB
        String category = params.category
        String illustration = params.illustration
        String author = params.author

        illustration = illustration.replaceAll(" ","+")
        String filename = "image-" + title + "-" + Illustration.count + ".jpg"

        BASE64Decoder decoder = new BASE64Decoder();
        def imageByte = decoder.decodeBuffer(illustration);
        ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
        def image = ImageIO.read(bis);
        File outputfile = new File(BuildSettings.BASE_DIR.toString() + immageDir + filename);
        ImageIO.write(image, "jpg", outputfile)
        Illustration newIllustration = new Illustration(filename: filename);
        newIllustration.save()
        Annonce annonce = new Annonce(title: title,description: description, price: price,
                active: active, category: category,author:author)
        annonce.addToIllustrations(newIllustration)
        annonce.save()
        return annonce
    }

    Annonce createAnnonce(def params) {
        final String immageDir = "\\grails-app\\assets\\images\\";
        float priceF = params.price
        boolean activeB = params.active
        String title = params.title
        String description = params.description
        Float price = priceF
        Boolean active = activeB
        String category = params.category
        String illustration = params.illustration
        Long author = authorisationService.getUserLogged().getId()

        illustration = illustration.replaceAll(" ","+")
        String filename = "image-" + title + "-" + Illustration.count + ".jpg"

        BASE64Decoder decoder = new BASE64Decoder();
        def imageByte = decoder.decodeBuffer(illustration);
        ByteArrayInputStream bis = new ByteArrayInputStream(imageByte);
        def image = ImageIO.read(bis);
        File outputfile = new File(BuildSettings.BASE_DIR.toString() + immageDir + filename);
        ImageIO.write(image, "jpg", outputfile)
        Illustration newIllustration = new Illustration(filename: filename);
        newIllustration.save()
        Annonce annonce = new Annonce(title: title,description: description, price: price,
                active: active, category: category,author:author)
        annonce.addToIllustrations(newIllustration)
        annonce.save()
        return annonce
    }


        // -- User
    boolean isAllParmsPresentUser(def params) {
        return params.username && params.password && params.role
    }

    boolean isAllParmsPresentUserNoRole(def params) {
        return params.username && params.password
    }

    boolean isParmsPresentUser(def params) {
        return params.username || params.password || params.role
    }

    void fullyUpdateUser(User userInstance,def params) {
        // get the values
        String username = params.username
        String password = params.password
        // set the values
        userInstance.setUsername(username)
        userInstance.setPassword(password)
        // update the annonce
        userInstance.save()
    }

    void partialUpdateUser(User userInstance,def params) {
        if(params.username) {
            String username = params.username
            userInstance.setUsername(username)
        }
        if(params.password) {
            String password = params.password
            userInstance.setPassword(password)
        }
        // update the annonce
        userInstance.save()
    }

    def deleteUser(User userInstance) {
        userInstance.delete()
    }


    // -- Users

    User createUserWithAdminRight(def params) {
        // get the values
        String username = params.username
        String password = params.password
        String role = params.role
        boolean active = true;
        if(params.active != null) {
            active = Boolean.parseBoolean(params.active)
        }
        if(role == null) {
            role = RoleType.ROLE_CLIENT
        } else if (!role.equals(RoleType.ROLE_CLIENT)
                && !role.equals(RoleType.ROLE_MODERATEUR)
                && !role.equals(RoleType.ROLE_ADMIN)) {
            role = RoleType.ROLE_CLIENT
        }
        // set the values
        User user = new User(username:username,password:password,role:role, enabled:active);
        user.save()
        return user
    }

    User creatUser(def params) {
        // get the values
        String username = params.username
        String password = params.password
        String role = RoleType.ROLE_CLIENT
        // set the values
        User user = new User(username:username,password:password,role:role);
        user.save()
        return user
    }
}
