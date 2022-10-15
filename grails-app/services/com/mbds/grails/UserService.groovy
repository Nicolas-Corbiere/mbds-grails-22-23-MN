package com.mbds.grails

import grails.gorm.transactions.Transactional
import util.RoleType

@Transactional
class UserService {

    User get(Serializable id) {
        return User.get(id)
    }

    List<User> list(Map args) {
        return User.list(args)
    }

    Long count() {
        return User.count()
    }

    void delete(Serializable id) {
        UserRole.list().forEach({ v ->
            if(v.getUserId().equals(id)) {
                v.delete()
            }
        })
        User.get(id).delete()
    }

    User save(User user) {
        return user.save()
    }

    UserRole getUserRole(User user,String role) {
        Role r = getRoleByName(role);
        if(r != null) {
            UserRole ur = null;
            UserRole.list().forEach( {
                if(it.equals(user.id)) {
                    ur = it
                }
            })
            return ur
        }
        else {
            return null
        }
    }

    void resetOldRole(User user) {
        if(getUserRole(user, RoleType.ROLE_ADMIN)  != null) {
            user.role = RoleType.ROLE_ADMIN
        } else if(getUserRole(user,RoleType.ROLE_MODERATEUR) != null) {
            user.role = RoleType.ROLE_MODERATEUR
        } else {
            user.role = RoleType.ROLE_CLIENT
        }
        user.save()
    }

    Role getRoleByName(String roleToSearch) {
        Role roleToReturn
        Role.list().forEach() {
            if(it.authority == roleToSearch && !roleToReturn) {
                roleToReturn = it;
            }
        }
        return roleToReturn
    }
}
