package mbds.grails

import hello.HelloWorld

class HelloWorldController {

    HelloWorld hello;

    def index() {
        hello = new HelloWorld(message: "Hello index").save()
        render hello.toString();
    }

    def hello() {
        hello = new HelloWorld(message: "Hello World !").save()
        render hello.toString();
    }
}
