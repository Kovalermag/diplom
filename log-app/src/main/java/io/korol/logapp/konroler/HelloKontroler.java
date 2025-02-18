package io.korol.logapp.konroler;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Random;

@RestController
@RequestMapping
        (path = "/ip/hello")

public class HelloKontroler {
    @GetMapping(path = "/{name}",produces = MediaType.APPLICATION_JSON_VALUE)
    public HelloDto greetings(@PathVariable(name = "name") String name) {
        System.out.printf("Hello Controller get request with name = %s \n", name);
        return new HelloDto().setId(new Random(300). nextLong()).setName(name);

    }

}

