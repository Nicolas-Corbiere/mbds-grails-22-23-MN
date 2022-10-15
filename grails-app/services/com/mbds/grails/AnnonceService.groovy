package com.mbds.grails

import grails.gorm.transactions.Transactional
import grails.util.BuildSettings

@Transactional
class AnnonceService {

    Annonce get(Serializable id) {
        return Annonce.get(id)
    }

    List<Annonce> list(Map args) {
        return Annonce.list(args)
    }

    List<Annonce> listFilteredAuthor(User user) {
        return Annonce.list().stream().filter( {
            it.author.id == user.id
        }).findAll()
    }

    List<Annonce> listFilteredCategory(String category) {
        return Annonce.list().stream().filter( {
            it.category.equals(category)
        }).findAll()
    }

    Long count() {
        return Annonce.count()
    }

    void delete(Serializable id) {
        Annonce.get(id).delete();
    }

    Annonce save(Annonce annonce) {
        return annonce.save();
    }

    void creatIllustrationForAnnonce(def request, Annonce annonce) {
        final String immageDir = "\\grails-app\\assets\\images\\";
        String output = BuildSettings.BASE_DIR.toString() + immageDir
        File assets = new File(output)
        int nbFile = assets.listFiles().length+1;
        String filename = "image-" + annonce.title + "-" + nbFile + ".jpg"
        request.getPart("illustrationz").each { file ->
            if(request.getPart("illustrationz").getSize()>0) {
                file.write(output + filename)
                Illustration newIllustration = new Illustration(filename: filename)
                newIllustration.save()
                annonce.addToIllustrations(newIllustration)
            } else {
                Illustration ill = new Illustration()
                ill.filename = "grails.svg"
                ill.annonce = annonce
                annonce.addToIllustrations(ill)
            }
        }
    }

    void creatIllustrationForAnnonceUpdate(def request, Annonce annonce) {
        if(request.getPart("illustrationz").getSize()>0) {
            final String immageDir = "\\grails-app\\assets\\images\\";
            String output = BuildSettings.BASE_DIR.toString() + immageDir
            File assets = new File(output)
            int nbFile = assets.listFiles().length+1;
            String filename = "image-" + annonce.title + "-" + nbFile + ".jpg"
            request.getPart("illustrationz").each { file ->
                file.write(output + filename)
                Illustration newIllustration = new Illustration(filename: filename)
                newIllustration.save()
                annonce.addToIllustrations(newIllustration)
                nbFile++
            }
        }
    }

    void removeIllustration(def params,Annonce annonce) {
        Set<Illustration> illustrations = annonce.getIllustrations()
        String labForDelete = "-delete"
        List<String> illustrationsToRemove = new ArrayList<>();
        for(Illustration illustration : illustrations) {
            String isDelete = params.get(illustration.getId() + labForDelete)
            if(isDelete) {
                illustrationsToRemove.add(illustration.getId())
            }
        }
        for(String idIllToRemove : illustrationsToRemove) {
            Illustration toRemove = Illustration.get(idIllToRemove)
            annonce.removeFromIllustrations(toRemove)
            toRemove.delete()
        }
    }
}
