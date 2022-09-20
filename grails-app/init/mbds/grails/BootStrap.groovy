package mbds.grails

class BootStrap {

    def init = { servletContext ->
        println("hello")
    }
    def destroy = {
    }
}
