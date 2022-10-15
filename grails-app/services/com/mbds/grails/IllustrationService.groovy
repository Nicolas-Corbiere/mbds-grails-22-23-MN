package com.mbds.grails

import grails.gorm.transactions.Transactional

@Transactional
class IllustrationService {

    Illustration get(Serializable id) {
        return Illustration.get(id)
    }

    List<Illustration> list(Map args) {
        return Illustration.list(args)
    }

    Long count() {
        return Illustration.count()
    }

    void delete(Serializable id) {
        Illustration.get(id).delete();
    }

    Illustration save(Illustration illustration) {
        return illustration.save()
    }
}
