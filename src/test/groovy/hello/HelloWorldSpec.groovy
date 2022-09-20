package hello

import grails.testing.gorm.DomainUnitTest
import spock.lang.Specification

class HelloWorldSpec extends Specification implements DomainUnitTest<HelloWorld> {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        expect:"fix me"
            true == false
    }
}
