package io.korol.logapp.konroler;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors (chain = true)
public class HelloDto {
    private Long id;
    private String name;

    public Long getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public HelloDto setId(Long id) {
        this.id = id;
        return this;
    }

    public HelloDto setName(String name) {
        this.name = name;
        return this;
    }
}
